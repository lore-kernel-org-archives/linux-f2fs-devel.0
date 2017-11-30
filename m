From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: pass down write hints to block
 layer for bufferd write
Date: Thu, 30 Nov 2017 15:06:25 +0800
Message-ID: <d71418e1-d667-3dc6-9265-61db5d8f40bc@huawei.com>
References: <1511828607-624-1-git-send-email-hyc.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKIvo-0008EF-Ly
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 07:06:48 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKIvm-0000cB-IG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 07:06:48 +0000
In-Reply-To: <1511828607-624-1-git-send-email-hyc.lee@gmail.com>
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
To: Hyunchul Lee <hyc.lee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, kernel-team@lge.com, linux-fsdevel@vger.kernel.org, Hyunchul Lee <cheol.lee@lge.com>

Hi Hyunchul,

On 2017/11/28 8:23, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> This implements which hint is passed down to block layer
> for datas from the specific segment type.
> 
> segment type                     hints
> ------------                     -----
> COLD_NODE & COLD_DATA            WRITE_LIFE_EXTREME
> WARM_DATA                        WRITE_LIFE_NONE
> HOT_NODE & WARM_NODE             WRITE_LIFE_LONG
> HOT_DATA                         WRITE_LIFE_MEDIUM
> META_DATA                        WRITE_LIFE_SHORT

Just noticed, if our user do not give the hint via ioctl, f2fs can
provider hint to lower layer according to hot/cold separation ability,
it will be okay. But once user give his hint which may be more accurate
than filesystem, hint converted by f2fs may be wrong.

So what do you think of adding an option to control whether filesystem
can convert hint user given?

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
