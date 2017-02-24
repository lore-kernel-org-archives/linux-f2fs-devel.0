From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: avoid m_flags overlay when allocating
 more data blocks
Date: Fri, 24 Feb 2017 19:16:55 +0800
Message-ID: <3a5e421f-0e0f-b0a2-2638-fb69a8c34423@huawei.com>
References: <088115ed-1cd1-1e3c-f282-0248773e6c1e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1chDs3-0001lS-Ew
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 11:17:07 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chDs2-0004Bb-CS
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 11:17:07 +0000
In-Reply-To: <088115ed-1cd1-1e3c-f282-0248773e6c1e@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/2/23 19:55, Kinglong Mee wrote:
> When more than one data blocks are allocated, the F2FS_MAP_UNWRITTEN/MAPPED
> flags will be overlapped by F2FS_MAP_NEW at the later times.
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
