From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: What commit v4.17 is?
Date: Mon, 11 Jun 2018 10:01:22 -0700
Message-ID: <20180611170122.GB6783@jaegeuk-macbookpro.roam.corp.google.com>
References: <VI1PR07MB16455C3E87BEE7172DF2BB61A1790@VI1PR07MB1645.eurprd07.prod.outlook.com>
 <VI1PR07MB164579C7BD26A5420FBB5191A1780@VI1PR07MB1645.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR07MB164579C7BD26A5420FBB5191A1780@VI1PR07MB1645.eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jorge,

On 06/11, Jorge Fernandez Monteagudo wrote:
> Hi all,
> 
> 
> This is my first message in the mailing list and is about what f2fs commit is present in the 4.17 kernel. I guess is a
> 
> very basic question but I'm not very skilled with git.
> 
> 
> Currently I'm using a 4.14 kernel I downloaded from https://kernel.googlesource.com/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable/+/linux-4.14.y
> 
> commit 00f0eaaadfe041ee518c5a9122a121864e56cd23 (Thu Jan 25 14:54:42 2018 +0800). This kernel is working ok for me because I need
> 
> my SSD disk with F2FS to recover from powerfail tests.
> 
> 
> Now I have to update to an 4.17 kernel in order to get my AMD graphic card to work but I don't want to lose the F2FS recovering capabilities.
> 
> Is the previous commit 00f0eaaadfe041ee518c5a9122a121864e56cd23 present in the vanilla 4.17 kernel I can download from kernel.org or

That commit was lastly merged in vanilla v4.16, which means v4.17 should include
all the commits that you've used.

Thanks,

> 
> I need a special kernel from f2fs or f2fs-stable?
> 
> 
> Thanks!
> 
