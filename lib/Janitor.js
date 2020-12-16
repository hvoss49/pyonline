class Janitor {
    /**
     * @param {!PythonOnline} pythonOnline
     * @param {number} compilationExpiration
     * @param {number} cleanTimeout
     */
    constructor(pythonOnline, compilationExpiration, cleanTimeout) {
        this._pythonOnline = pythonOnline;
        this._compilationExpiration = compilationExpiration;
        this._cleanTimeout = cleanTimeout;
        this._cleanup();
    }

    async _cleanup() {
        var compilations = this._pythonOnline.compilations().filter(compilation => compilation.finished);

        var currentTime = Date.now();
        for (var compilation of compilations) {
            var interval = currentTime - compilation.accessTime;
            var expired = interval > this._compilationExpiration;
            if (expired) {
                this._pythonOnline.removeCompilation(compilation);
            }
        }
        setTimeout(this._cleanup.bind(this), this._cleanTimeout);
    }
}

module.exports = Janitor;
