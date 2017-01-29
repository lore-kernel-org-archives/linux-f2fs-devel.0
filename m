From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 0/5] Fix coding style errors and warnings in
 f2fs.h
Date: Sun, 29 Jan 2017 13:23:42 +0900
Message-ID: <20170129042342.GD65555@jaegeuk.local>
References: <20170127182940.11389-1-doscode.kr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cXh20-0003Zp-7a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 29 Jan 2017 04:24:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cXh1z-00027i-2J
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 29 Jan 2017 04:24:00 +0000
Content-Disposition: inline
In-Reply-To: <20170127182940.11389-1-doscode.kr@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: DongOh Shin <doscode.kr@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi DongOh,

It doesn't need to split everything with same patch subjects. So, could
you please submit two patches?
- f2fs: fix coding style errors in f2fs.h
- f2fs: fix coding style warnings in f2fs.h

Thanks,

On 01/27, DongOh Shin wrote:
> f2fs.h has 3 errors and 454 warnings on the coding style.
> This series of patches resolve 3 errors and 446 warnings below:
> 0001, error,   "Macros with complex values should be enclosed in parentheses"
> 0002, error,   "space prohibited before that ',' (ctx:WxW)"
> 0003, warning, "Missing a blank line after declarations"
> 0004, warning, "function definition argument 'x' should also have an identifier name"
> 0005, warning, "macros should not use a trailing semicolon"
> 
> So, after applying this patch, it is reduced to 8 warnings only.
> 
> DongOh Shin (5):
>   Fix coding style errors in f2fs.h
>   Fix coding style error in f2fs.h
>   Fix coding style warnings in f2fs.h
>   Fix coding style warnings in f2fs.h
>   Fix coding style warnings in f2fs.h
> 
>  fs/f2fs/f2fs.h | 502 +++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 272 insertions(+), 230 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
