From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/5] f2fs: fix not to drop mount options when
 retrying fill_super
Date: Thu, 29 Jan 2015 19:24:59 +0800
Message-ID: <002a01d03bb6$530c8340$f92589c0$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YGnEQ-0005QY-JR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Jan 2015 11:25:54 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YGnEO-0006e3-OO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Jan 2015 11:25:54 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NIX008L3RQXBJ40@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Jan 2015 20:25:45 +0900 (KST)
In-reply-to: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: linux-fsdevel-owner@vger.kernel.org [mailto:linux-fsdevel-owner@vger.kernel.org] On
> Behalf Of Jaegeuk Kim
> Sent: Wednesday, January 28, 2015 7:32 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [PATCH 1/5] f2fs: fix not to drop mount options when retrying fill_super
> 
> If wrong mount option was requested, f2fs tries to fill_super again.
> But, during the next trial, f2fs has no valid mount options, since
> parse_options deleted all the separators in the original string.

Nice catch!

But couldn't we encounter memory leak for options if we did not fail to fill super.

Thanks,


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
