From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH V1 02/14] Consolidate "post read processing"
 into a new file
Date: Wed, 24 Apr 2019 20:29:10 +0530
Message-ID: <7402364.ucYHGh3o57@localhost.localdomain>
References: <20190424043730.13683-1-chandan@linux.ibm.com>
 <6353008.fQNhCuxumZ@localhost.localdomain>
 <20190424142423.GA12761@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hJJM3-0001pF-UG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 14:58:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJJM2-00BB1Q-2O
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 14:58:35 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3OEst8b060438
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 10:58:23 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2s2qpng2dw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 10:58:23 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Wed, 24 Apr 2019 15:58:21 +0100
In-Reply-To: <20190424142423.GA12761@infradead.org>
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

On Wednesday, April 24, 2019 7:54:23 PM IST Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 03:34:17PM +0530, Chandan Rajendra wrote:
> > To clarify, Are you suggesting that a new kconfig option (say
> > CONFIG_FS_READ_CALLBACKS) be provided to the user so that the following could
> > occur,
> > 
> > 1. User selects CONFIG_FS_ENCRYPTION and/or CONFIG_FS_VERITY and this causes
> > CONFIG_FS_READ_CALLBACKS to be set to 'y'.
> > 2. User selects CONFIG_FS_READ_CALLBACKS explicitly.
> 
> If you don't add a user description to a Kconfig entry it won't be
> visible to users, but only selectable by other options.  That is what
> I suggest.
> 
> 

Thanks for the clarification. I will make the necessary changes.

-- 
chandan
