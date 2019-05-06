From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH 09/13] fscrypt: support decrypting multiple
 filesystem blocks per page
Date: Mon, 06 May 2019 14:39:22 +0530
Message-ID: <2349515.8nsl4jZa1H@dhcp-9-109-212-164>
References: <20190501224515.43059-1-ebiggers@kernel.org>
 <20190501224515.43059-10-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hNbse-0004EC-Rd
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 May 2019 11:34:00 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hNbsb-007BJv-6a
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 May 2019 11:34:00 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x46BWnDL116574
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 6 May 2019 07:33:51 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sajd2m9u9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 06 May 2019 07:33:51 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Mon, 6 May 2019 12:33:49 +0100
In-Reply-To: <20190501224515.43059-10-ebiggers@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net

On Thursday, May 2, 2019 4:15:11 AM IST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Rename fscrypt_decrypt_page() to fscrypt_decrypt_pagecache_blocks() and
> redefine its behavior to decrypt all filesystem blocks in the given
> region of the given page, rather than assuming that the region consists
> of just one filesystem block.  Also remove the 'inode' and 'lblk_num'
> parameters, since they can be retrieved from the page as it's already
> assumed to be a pagecache page.
> 
> This is in preparation for allowing encryption on ext4 filesystems with
> blocksize != PAGE_SIZE.
> 
> This is based on work by Chandan Rajendra.

Looks good to me,

Reviewed-by: Chandan Rajendra <chandan@linux.ibm.com>

-- 
chandan
