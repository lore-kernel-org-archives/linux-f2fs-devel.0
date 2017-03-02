From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: skip writeback meta pages if
 cp_mutex acquire failed
Date: Thu, 2 Mar 2017 09:36:42 +0800
Message-ID: <a12d77db-3374-b76c-985c-0cc6e24cb9f1@huawei.com>
References: <20170301100710.9386-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cjFgE-0002vE-3C
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Mar 2017 01:37:18 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cjFgC-0004Nc-VN
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Mar 2017 01:37:18 +0000
In-Reply-To: <20170301100710.9386-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/1 18:07, Yunlei He wrote:
> Skip writeback meta pages if cp_mutex lock acquire failed, cp will
> flush dirty pages instead.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
