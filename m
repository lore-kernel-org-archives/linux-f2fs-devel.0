From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/3] f2fs: Reduce zoned block device memory
 usage
Date: Tue, 19 Mar 2019 19:01:21 +0800
Message-ID: <ccdd3a3f-6045-49fe-2eca-af6fa4d0bdda@huawei.com>
References: <20190316001308.18115-1-damien.lemoal@wdc.com>
 <20190316001308.18115-3-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1h6CUx-0000st-Vx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Mar 2019 11:01:35 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h6CUv-00DNSM-U2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Mar 2019 11:01:35 +0000
In-Reply-To: <20190316001308.18115-3-damien.lemoal@wdc.com>
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
> For zoned block devices, an array of zone types for each device is
> allocated and initialized in order to determine if a section is stored
> on a sequential zone (zone reset needed) or a conventional zone (no
> zone reset needed and regular discard applies). Considering this usage,
> the zone types stored in memory can be replaced with a bitmap to
> indicate an equivalent information, that is, if a zone is sequential or
> not. This reduces the memory usage for each zoned device by roughly 8:
> on a 14TB disk with zones of 256 MB, the zone type array consumes
> 13x4KB pages while the bitmap uses only 2x4KB pages.
> 
> This patch changes the f2fs_dev_info structure blkz_type field to the
> bitmap blkz_seq. Access to this bitmap is done using the helper
> function f2fs_blkz_is_seq(), which is a rewrite of the function
> get_blkz_type().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
