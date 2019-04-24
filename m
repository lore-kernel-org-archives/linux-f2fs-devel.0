From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH V1 02/14] Consolidate "post read processing"
 into a new file
Date: Wed, 24 Apr 2019 15:34:17 +0530
Message-ID: <6353008.fQNhCuxumZ@localhost.localdomain>
References: <20190424043730.13683-1-chandan@linux.ibm.com>
 <20190424043730.13683-3-chandan@linux.ibm.com>
 <20190424053544.GA12092@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hJGAU-0002t9-3s
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 11:34:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJGAS-009zaP-4J
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 11:34:26 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3OBTZlC142780
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 07:34:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2s2n3fdysm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 07:34:17 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Wed, 24 Apr 2019 12:34:16 +0100
In-Reply-To: <20190424053544.GA12092@infradead.org>
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
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Wednesday, April 24, 2019 11:05:44 AM IST Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 10:07:18AM +0530, Chandan Rajendra wrote:
> > +ifeq (y, $(firstword $(filter y,$(CONFIG_FS_ENCRYPTION) $(CONFIG_FS_VERITY))))
> > +obj-y +=	post_read_process.o
> > +endif
> 
> Please just add a new config option selected by the users.
>

Hi Christoph,

To clarify, Are you suggesting that a new kconfig option (say
CONFIG_FS_READ_CALLBACKS) be provided to the user so that the following could
occur,

1. User selects CONFIG_FS_ENCRYPTION and/or CONFIG_FS_VERITY and this causes
CONFIG_FS_READ_CALLBACKS to be set to 'y'.
2. User selects CONFIG_FS_READ_CALLBACKS explicitly.


> Also I find the file name rather cumbersome.  Maybe just
> read-callbacks.[co] ?
> 

I will do this.

-- 
chandan
