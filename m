From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V1 02/14] Consolidate "post read processing"
 into a new file
Date: Tue, 23 Apr 2019 22:35:44 -0700
Message-ID: <20190424053544.GA12092@infradead.org>
References: <20190424043730.13683-1-chandan@linux.ibm.com>
 <20190424043730.13683-3-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+b85c7aa3a76ea8f4c774+5722+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1hJAZb-0000m7-4m
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 05:35:59 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJAZX-00ADC3-CH
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 05:35:59 +0000
Content-Disposition: inline
In-Reply-To: <20190424043730.13683-3-chandan@linux.ibm.com>
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
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Wed, Apr 24, 2019 at 10:07:18AM +0530, Chandan Rajendra wrote:
> +ifeq (y, $(firstword $(filter y,$(CONFIG_FS_ENCRYPTION) $(CONFIG_FS_VERITY))))
> +obj-y +=	post_read_process.o
> +endif

Please just add a new config option selected by the users.

Also I find the file name rather cumbersome.  Maybe just
read-callbacks.[co] ?
