From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/4] f2fs: avoid very large discard command
Date: Mon, 27 Feb 2017 10:09:22 +0800
Message-ID: <13168913-ac43-87b1-4411-7e054fbb2b82@huawei.com>
References: <20170223042850.43456-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciAkq-0008AT-P5
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 02:09:36 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciAkp-0003kN-EU
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 02:09:36 +0000
In-Reply-To: <20170223042850.43456-1-jaegeuk@kernel.org>
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

On 2017/2/23 12:28, Jaegeuk Kim wrote:
> This patch adds MAX_DISCARD_BLOCKS() to avoid issuing too much large single
> discard command.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

This patch set looks good to me, please add reviewed-by into all patches. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
