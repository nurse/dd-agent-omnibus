# ------------------------------------
# Go-setup helper functions
# ------------------------------------
#
def go_setup(version)
  if windows?
    gourl = "https://storage.googleapis.com/golang/go#{version}.windows-amd64.zip"
    goout = "go.zip"
    godir = "c:/go#{version}"
    gobin = "#{godir}/go/bin/go"
  else
    gourl = "https://storage.googleapis.com/golang/go#{version}.linux-amd64.tar.gz"
    goout = "go.tar.gz"
    godir = "/usr/local/go#{version}"
    gobin = "#{godir}/go/bin/go"
  end

  # download go
  command "curl #{gourl} -o #{goout}"

  delete godir
  mkdir godir

  if windows? 
   command "7z x -o#{godir} #{goout} "
  else
   command "tar zxfv #{goout} -C #{godir}"
  end
  delete goout

  godir
end