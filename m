From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] f2fs: Reduce zoned block device memory usage
Date: Wed, 21 Feb 2018 02:49:00 +0000
Message-ID: <819e307a-fa60-4114-3932-dee664f88ddd@wdc.com>
References: <20180220060610.12588-1-damien.lemoal@wdc.com>
 <20180221023905.GA13864@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <prvs=583bacafe=Damien.LeMoal@wdc.com>)
 id 1eqmmG-007Whh-Sc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Feb 2018 21:27:12 +0000
Received: from [172.30.20.11] (helo=esa5.hgst.iphmx.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps (TLSv1.2:RC4-SHA:128)
 (Exim 4.89) id 1eoKSu-0006VW-8k
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Feb 2018 02:49:05 +0000
In-Reply-To: <20180221023905.GA13864@infradead.org>
Content-Language: en-US
Content-ID: <FE52FB3DFC7EBE44BA22F5B78E103236@namprd04.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Christoph,

On 2/21/18 11:39, Christoph Hellwig wrote:
> On Tue, Feb 20, 2018 at 03:06:10PM +0900, Damien Le Moal wrote:
>> For a zoned block device mount, an array of zone types for the device is
>> allocated and initialized in order to determine if a section is stored
>> on a sequential zone (zone reset needed) or a conventional zone (no zone
>> reset needed and regular discard applies). Considering this usage, the
>> zone types stored in memory can be replaced with a bitmap to indicate
>> equivalent information, that is, if a zone is sequential or not. This
>> reduces the memory usage for the device mount by roughly 8 (on a 14TB
>> disk with zones of 256 MB, the zone type array consumes 13x4KB pages
>> while the bitmap uses only 2x4KB pages.
>>
>> This patch changes the f2fs_dev_info structure blkz_type field to the
>> bitmap blkz_seq. Access to this bitmap is done using the function
>> f2fs_blkz_is_seq(), which is a rewrite of the function get_blkz_type().
> 
> Is there any way we could just provide a block layer helper to
> figure this out so that the file system code could be simplified even
> more?

I thought about that before sending the patch...

For a physical drive, the block device queue already has the bitmap
indicating sequential zones, and a helper could be used in that case.
But that is not true if the FS block device is a logical device provided
by something like dm. E.g. if the FS mounts a zoned block device that is
a part of a real disk split by dm-linear, then there is no sequential
zone bitmap available, and the FS has to discover that by itself.

Currently, the sequential zone bitmap is initialized in the scsi driver
only. We could move that initialization to the block device layer at
some point when the bdev is created and requests can be sent to the
underlying dev, but before the bdev is exposed. Any suggestion of an
appropriate place to do that ? I do not see any obvious path that works
in all cases (real disks and dm).

-- 
Damien Le Moal,
Western Digital
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
