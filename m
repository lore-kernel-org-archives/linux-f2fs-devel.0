From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: add unlikely() macro for compiler more
	aggressively
Date: Fri, 06 Dec 2013 16:34:07 +0800
Message-ID: <000401cef25e$16f97d60$44ec7820$@samsung.com>
References: <1386310509-5864-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Voqsl-0001lj-4T
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Dec 2013 08:35:31 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Voqsj-0005yy-21
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Dec 2013 08:35:31 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MXD00AYLMISGZ90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Dec 2013 17:35:16 +0900 (KST)
In-reply-to: <1386310509-5864-1-git-send-email-jaegeuk.kim@samsung.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Friday, December 06, 2013 2:15 PM
> Cc: Jaegeuk Kim; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net; Chao Yu
> Subject: [PATCH] f2fs: add unlikely() macro for compiler more aggressively
> 
> This patch adds unlikely() macro into the most of codes.
> The basic rule is to add that when:
> - checking unusual errors,
> - checking page mappings,
> - and the other unlikely conditions.

Looks nice to me!

> 
> Cc: Chao Yu <chao2.yu@samsung.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/checkpoint.c |  22 ++++++----
>  fs/f2fs/data.c       |  63 +++++++++++++--------------
>  fs/f2fs/dir.c        |  10 ++---
>  fs/f2fs/file.c       |  23 +++++-----
>  fs/f2fs/gc.c         |  19 ++++-----
>  fs/f2fs/inode.c      |  12 +++---
>  fs/f2fs/namei.c      |  24 ++++++-----
>  fs/f2fs/node.c       | 117 +++++++++++++++++++++++++++------------------------
>  fs/f2fs/recovery.c   |  10 ++---
>  fs/f2fs/segment.c    |  42 +++++++++---------
>  fs/f2fs/super.c      |  83 ++++++++++++++++++------------------
>  fs/f2fs/xattr.c      |  28 ++++++------
>  12 files changed, 234 insertions(+), 219 deletions(-)

[snip]

> @@ -808,11 +808,11 @@ retry:
>  		brelse(*raw_super_buf);
>  		f2fs_msg(sb, KERN_ERR, "Can't find a valid F2FS filesystem "
>  				"in %dth superblock", block + 1);
> -		if(block == 0) {
> +		if(unlikely(block != 0)) {

Original code has style problem:
Space is required before the open parenthesis '('.
Thanks.



------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
