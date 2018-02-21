From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: Reduce zoned block device memory usage
Date: Tue, 20 Feb 2018 18:39:05 -0800
Message-ID: <20180221023905.GA13864@infradead.org>
References: <20180220060610.12588-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89) (envelope-from
 <BATV+53e37238c2b78c0cda71+5295+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1eqvLi-008PIR-U5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 06:36:23 +0000
Received: from [172.30.20.11] (helo=bombadil.infradead.org)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eoKcy-0007Z3-3d
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Feb 2018 02:59:29 +0000
Content-Disposition: inline
In-Reply-To: <20180220060610.12588-1-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Feb 20, 2018 at 03:06:10PM +0900, Damien Le Moal wrote:
> For a zoned block device mount, an array of zone types for the device is
> allocated and initialized in order to determine if a section is stored
> on a sequential zone (zone reset needed) or a conventional zone (no zone
> reset needed and regular discard applies). Considering this usage, the
> zone types stored in memory can be replaced with a bitmap to indicate
> equivalent information, that is, if a zone is sequential or not. This
> reduces the memory usage for the device mount by roughly 8 (on a 14TB
> disk with zones of 256 MB, the zone type array consumes 13x4KB pages
> while the bitmap uses only 2x4KB pages.
> 
> This patch changes the f2fs_dev_info structure blkz_type field to the
> bitmap blkz_seq. Access to this bitmap is done using the function
> f2fs_blkz_is_seq(), which is a rewrite of the function get_blkz_type().

Is there any way we could just provide a block layer helper to
figure this out so that the file system code could be simplified even
more?

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
