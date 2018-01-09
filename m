From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH -next] f2fs: make local functions static
Date: Tue, 9 Jan 2018 10:08:47 +0800
Message-ID: <cefe83fc-483e-6438-a4b4-1be0ae2fbfff@huawei.com>
References: <1515145280-28626-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eYjLz-0007nx-GB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 02:09:27 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYjLy-0002Y2-A7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 02:09:27 +0000
In-Reply-To: <1515145280-28626-1-git-send-email-weiyongjun1@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Wei Yongjun <weiyongjun1@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/1/5 17:41, Wei Yongjun wrote:
> Fixes the following sparse warnings:
> 
> fs/f2fs/segment.c:887:6: warning:
>  symbol '__check_sit_bitmap' was not declared. Should it be static?
> fs/f2fs/segment.c:1327:6: warning:
>  symbol 'f2fs_wait_discard_bio' was not declared. Should it be static?
> fs/f2fs/super.c:1661:5: warning:
>  symbol 'f2fs_get_projid' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
