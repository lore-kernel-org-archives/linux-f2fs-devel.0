From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: improve discard handling with
 multi-device volumes
Date: Tue, 19 Mar 2019 19:02:39 +0800
Message-ID: <f0df706d-3f6d-6c70-688c-147fa4e78d07@huawei.com>
References: <20190316001308.18115-1-damien.lemoal@wdc.com>
 <20190316001308.18115-4-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1h6CWI-0000yO-2t
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Mar 2019 11:02:58 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h6CWG-00DNae-GF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Mar 2019 11:02:57 +0000
In-Reply-To: <20190316001308.18115-4-damien.lemoal@wdc.com>
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
To: Damien Le Moal <damien.lemoal@wdc.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Masato Suzuki <masato.suzuki@wdc.com>, Matias Bjorling <matias.bjorling@wdc.com>

On 2019/3/16 8:13, Damien Le Moal wrote:
> f2fs_hw_support_discard() only tests if the super block device supports
> discard. However, for a multi-device volume, not all disks used may
> support discard. Improve the check performed to test all devices of
> the volume and report discard as supported if at least one device of
> the volume supports discard. To implement this, introduce the helper
> function f2fs_bdev_support_discard(), which returns true for zoned block
> devices (where discard is processed as a zone reset) and for regular
> disks supporting the discard command.
> 
> f2fs_bdev_support_discard() is also used in __queue_discard_cmd() to
> handle discard command issuing for a particular device of the volume.
> That is, prevent issuing a discard command for block devices that do
> not support it.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
