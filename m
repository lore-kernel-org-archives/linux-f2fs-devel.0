From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: Security fixes for 4.4 - f2fs
Date: Tue, 22 Jan 2019 14:51:01 +0000
Message-ID: <1548168661.3229.185.camel@codethink.co.uk>
References: <1547753327.3229.115.camel@codethink.co.uk>
         <20190118081946.GA17484@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190118081946.GA17484@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>, stable <stable@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, 2019-01-18 at 09:19 +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 17, 2019 at 07:28:47PM +0000, Ben Hutchings wrote:
> > I've backported fixes for several security issues involving
> > filesystem
> > validation in f2fs.  All of these are already fixed in the later
> > stable
> > branches.
> > 
> > I tested with the reproducers where available.  I also checked for
> > regressions with xfstests and didn't find any (but many tests fail
> > with
> > or without these changes).
> 
> Thanks for all of these, now queued up.
> 
> Note, one of these, d4fdf8ba0e58 ("f2fs: fix a panic caused by NULL
> flush_cmd_control"), was already in the 4.4.169 release.

Sorry about that - it took me some time to prepare and test these and I
was starting from a base of 4.4.167.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
