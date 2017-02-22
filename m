From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 5/6] f2fs: add a kernel thread to issue
 discard commands asynchronously
Date: Wed, 22 Feb 2017 17:40:37 +0800
Message-ID: <edfa686e-add4-447a-35ec-104a30861b65@huawei.com>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
	<20170112224407.54026-5-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cgTQJ-0000dL-Qx
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 09:41:23 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgTQJ-0003CJ-0e
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 09:41:23 +0000
In-Reply-To: <20170112224407.54026-5-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/1/13 6:44, Jaegeuk Kim wrote:
> This patch adds a kernel thread to issue discard commands.
> It proposes three states, D_PREP, D_SUBMIT, and D_DONE to identify current
> bio status.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
