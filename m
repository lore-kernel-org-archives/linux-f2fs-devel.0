From: Greg KH <greg@kroah.com>
Subject: Re: [PATCHv2 1/1] f2fs: sanity check checkpoint segno and blkoff
Date: Sun, 14 May 2017 12:51:31 +0200
Message-ID: <20170514105131.GA30064@kroah.com>
References: <20170512175040.16387-1-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512175040.16387-1-jinqian@android.com>
Sender: stable-owner@vger.kernel.org
To: Jin Qian <jinqian@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, Jin Qian <jinqian@android.com>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, May 12, 2017 at 10:50:40AM -0700, Jin Qian wrote:
> Make sure segno and blkoff read from raw image are valid.
> 
> Change-Id: Ia37f5e03aba85f483ddad7a38c64c8e2dbb02243

What is this here for?  That's not really wanted on kernel patches :)

thanks,

greg k-h
