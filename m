From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [RFC PATCH 00/10] Consolidate Post read processing
 code
Date: Thu, 21 Feb 2019 19:02:03 +0530
Message-ID: <2420837.hecoV8S9Z6@localhost.localdomain>
References: <20190218100433.20048-1-chandan@linux.ibm.com>
 <20190220004107.GI12177@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1gwoS8-0007EJ-0s
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Feb 2019 13:31:52 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gwoS6-00EM0N-0w
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Feb 2019 13:31:51 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LDUKSn050932
 for <linux-f2fs-devel@lists.sourceforge.net>; Thu, 21 Feb 2019 08:31:41 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qsum63ra7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Thu, 21 Feb 2019 08:31:40 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Thu, 21 Feb 2019 13:31:39 -0000
In-Reply-To: <20190220004107.GI12177@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Wednesday, February 20, 2019 6:11:07 AM IST Eric Biggers wrote:
> On Mon, Feb 18, 2019 at 03:34:23PM +0530, Chandan Rajendra wrote:
> > Based on the reviews provided for this patchset, I
> > will change F2FS to use mpage_readpage[s] and post the next version of
> > this patchset to linux-fsdevel mailing list.
> 
> Is that really possible?  F2FS has other functionality in its ->readpages(),
> such as support for filesystems that use multiple block devices.
> 

Hmm. I didn't know that. Thanks for pointing that out. I will read up that
code and if it isn't really possible to get F2FS to use mpage_readpage[s](),
then I would limit the patchset to Ext4.

-- 
chandan
