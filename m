From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH RESEND] f2fs:Fix incorrect return statement
 in the function f2fs_ioc_release_volatile_write
Date: Tue, 08 Sep 2015 19:47:14 +0800
Message-ID: <002201d0ea2c$37168df0$a543a9d0$@samsung.com>
References: <1441542526-11916-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZZHNh-0004fn-Ox
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Sep 2015 11:48:09 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZZHNf-0003Hn-MS
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Sep 2015 11:48:09 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUC01JVUWS0N1C0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Sep 2015 20:48:00 +0900 (KST)
In-reply-to: <1441542526-11916-1-git-send-email-xerofoify@gmail.com>
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
To: 'Nicholas Krause' <xerofoify@gmail.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Nicholas Krause [mailto:xerofoify@gmail.com]
> Sent: Sunday, September 06, 2015 8:29 PM
> To: jaegeuk@kernel.org
> Cc: cm224.lee@samsung.com; chao2.yu@samsung.com; linux-f2fs-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org
> Subject: [PATCH RESEND] f2fs:Fix incorrect return statement in the function
> f2fs_ioc_release_volatile_write
> 
> This fixes the incorrect return statement at the end of the function
> f2fs_ioc_release_volatile_write's body for returning zero as this is
> incorrect due to the function call before this return statement to
> the function punch_hole being able to fail and we should return this
> function's return fail directly in order to signal to callers of the
> function f2fs_ioc_release_volatile if a failure arises with this call
> to punch_hole fails.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
