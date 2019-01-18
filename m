From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Security fixes for 4.4 - f2fs
Date: Fri, 18 Jan 2019 09:19:46 +0100
Message-ID: <20190118081946.GA17484@kroah.com>
References: <1547753327.3229.115.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547753327.3229.115.camel@codethink.co.uk>
Sender: stable-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>, stable <stable@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jan 17, 2019 at 07:28:47PM +0000, Ben Hutchings wrote:
> I've backported fixes for several security issues involving filesystem
> validation in f2fs.  All of these are already fixed in the later stable
> branches.
> 
> I tested with the reproducers where available.  I also checked for
> regressions with xfstests and didn't find any (but many tests fail with
> or without these changes).

Thanks for all of these, now queued up.

Note, one of these, d4fdf8ba0e58 ("f2fs: fix a panic caused by NULL
flush_cmd_control"), was already in the 4.4.169 release.

thanks,

greg k-h
