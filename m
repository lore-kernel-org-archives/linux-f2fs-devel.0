From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V1 02/14] Consolidate "post read processing"
 into a new file
Date: Wed, 24 Apr 2019 07:24:23 -0700
Message-ID: <20190424142423.GA12761@infradead.org>
References: <20190424043730.13683-1-chandan@linux.ibm.com>
 <20190424043730.13683-3-chandan@linux.ibm.com>
 <20190424053544.GA12092@infradead.org>
 <6353008.fQNhCuxumZ@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+b85c7aa3a76ea8f4c774+5722+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1hJIpF-0000OI-6o
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 14:24:41 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJIpA-00Ak3u-Ei
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 14:24:41 +0000
Content-Disposition: inline
In-Reply-To: <6353008.fQNhCuxumZ@localhost.localdomain>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.ibm.com>
Cc: ebiggers@kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Wed, Apr 24, 2019 at 03:34:17PM +0530, Chandan Rajendra wrote:
> To clarify, Are you suggesting that a new kconfig option (say
> CONFIG_FS_READ_CALLBACKS) be provided to the user so that the following could
> occur,
> 
> 1. User selects CONFIG_FS_ENCRYPTION and/or CONFIG_FS_VERITY and this causes
> CONFIG_FS_READ_CALLBACKS to be set to 'y'.
> 2. User selects CONFIG_FS_READ_CALLBACKS explicitly.

If you don't add a user description to a Kconfig entry it won't be
visible to users, but only selectable by other options.  That is what
I suggest.
