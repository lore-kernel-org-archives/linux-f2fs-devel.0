Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032FCC982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H4KYMb7Vp0AKcl7LR9Mo0sZ9DS/VqLPXxxTh5k2RDzA=; b=CvaufhlZhJM+QLHMLYFGYhzi3/
	pQdqTxRT6UH9ot5+SYqC2EIzQqYBlPEYZlbRvLo12cfSQhFCz6LSKD7jI49Fz6n6F6MVqLA5eYWIL
	aYoiXHanXGClEWbJTQ4uJXVdXUeQLe82dIRLVkdvUJ/vHSQNXFMJzQ/NB6Pco8uc8dmo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8wmp-0005EZ-6A;
	Tue, 22 Sep 2026 09:27:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1x8wmn-0005EQ-9r
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AhIe1Z57w2l/HJoSK8VK6KQJtUlMI8/EsSSaoJvVLck=; b=ka1RC+PK+/UuXfgUxtCbsJnSJz
 ogrpnCElQwoMB2dWbN2ZXCC0JZh5eG74akEWXIEREJSoYF6Wea4ReBcfY0B5+3CICyM9tUWpy4B2e
 HPt3a+Vjzaj5WsrvLHGIbK4ZzIIUjXdqbdpaLSf4XuT9facAVnGiGA1UxeKs5kQ0JvrM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AhIe1Z57w2l/HJoSK8VK6KQJtUlMI8/EsSSaoJvVLck=; b=BkGhDR9tLqRkgCOa680ZjAvrZO
 dFUyjrz4WTKaD+GY3sqsAt/Qc9ii8Kzy1P7eq5UR0NcLlmS0OjmWk5ARUse2yLI2pySjIgcLdRTbb
 Cjot0OHPK/K/kRM5HvYPt5H6XRxFL/TqB1U2QRiLJhI67n+YZ18H5tgKNg8gweLl52Zk=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8wmm-0004Qn-6C for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:27:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790069249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AhIe1Z57w2l/HJoSK8VK6KQJtUlMI8/EsSSaoJvVLck=;
 b=CJeyJTHt3nxaRfNL2ShyFBlqBtvxS4A1IZMViQo+BUagJPbozHdz1Y4c00rcR+k7v5WmPH
 8tQdsqhEpL0pZ2WfR7QdjWmNyjwnjhELz8pNxgd/qIp/j0wnG33MS+KpvUUAFBfo04n3uQ
 G/FA1Zni6vJmAO+u+9w+WCXcGv5t6nc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-PTUcK7lHNRCbzwXSiEM-Jw-1; Tue, 22 Sep 2026 05:27:26 -0400
X-MC-Unique: PTUcK7lHNRCbzwXSiEM-Jw-1
X-Mimecast-MFC-AGG-ID: PTUcK7lHNRCbzwXSiEM-Jw_1790069245
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767b782so30988245e9.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 02:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790069245; x=1790674045;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AhIe1Z57w2l/HJoSK8VK6KQJtUlMI8/EsSSaoJvVLck=;
 b=F2aWZC/BIrski3itwickuwPzKcqYCe/UfR2L45VSj32xhL7vth2c7XLsYhlCa04vje
 NIqKUPe98CwxF6zwp8Q4MplNGqhVyMvMyXH3rTenT/9F71potalKY/5t9V6zpfZeVTTJ
 FrQhYgMhYEL4GADkX/abo54cAgbIJ+zQNC20O9qnZ3ufb1AuOIRy+kGCxA4mDxsRwz2F
 XbjAMCaaZllCJ0iDnO9W1XOEZf34+7CcX7XW1qfD52DnBZB3PC8++cwGCVOVaKFfJb8t
 sO7e9XKLIFBYmKV28aLdWCGLZrhz36XaTKSsg+XNZczvS1x7Y4SOTKs7E/L4F13DLIJN
 2Pmw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJSx6pCdYogh8k/gofO7oD8AMA6LQEJggnkYhtQ+Dg5P6fLv8tdWvdvIIEHhyQWUoQlGHVFTLOGwEF0vzoTaQy@lists.sourceforge.net
X-Gm-Message-State: AFuF++lknMWTPiJNimv48Kb0ajw3Yj1t6Vaq7s5wET08Ea871/CaSz7r
 rC1gy2Aez71UKL7pvwPITiY3s9IxJ7bFnRcyw+Ed5jCYNwA/mE19nBA6F63cZyCEuyZpF3PKQro
 2BRfvhlCYcDTqPto8QuZ5W3XLvw5uE03mD+h2X5QG0twvQRYM63G/KIHAbtmuwmC5gk3DlyFC1B
 vBtw==
X-Gm-Gg: AYBFou149vdz5PNg4e+IZufX4oHG9AYMuwQ8vn46srqRlHcEbyg/CWvgt337i/Uo55S
 YYOtirmEa4yWBEgiDsg9VFysFcsCiLWZ91wK+mFVyShZAB/VICG2SZ8bL8Mq+D50i3thYL0TP/y
 BCbbVvnfCj3qWD8rerjw5292ogZ3oOsk0w08kQ2gy6E+GHFFEVuycsAQCZH4hf402y8m0OAYbQ9
 URc3YH+GMqqeT1ki/mQlnDhpkbtgKqYDPZn2n8IIQ6+snEpLMjpn5Jd3mL3CYyM/q9PAJFYFyrU
 gWctXwlc4jmibFpSFx2ZoM05//WWY0VpnOBmeHgr4pO2iSGXt5PIBlvgJq8tLmKy/fbaN6Xq0f7
 /FJUdPOPgyaOwDD1daIaXiC8N0dOKIF6FJw==
X-Received: by 2002:a05:600c:3b8a:b0:49d:1d6a:4cfb with SMTP id
 5b1f17b1804b1-49fc56db759mr251806735e9.1.1790069245088; 
 Tue, 22 Sep 2026 02:27:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8a:b0:49d:1d6a:4cfb with SMTP id
 5b1f17b1804b1-49fc56db759mr251806285e9.1.1790069244518; 
 Tue, 22 Sep 2026 02:27:24 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda8f04f7sm59590685e9.0.2026.09.22.02.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 02:27:24 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:27:23 +0200
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <arJHLT1tuHCxZqkR@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-16-aalbersh@kernel.org>
 <20260922044559.GO2705364@frogsfrogsfrogs>
MIME-Version: 1.0
In-Reply-To: <20260922044559.GO2705364@frogsfrogsfrogs>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Ry_PTau2aVtQrC_6RIJSOqbfu_GUHDpfYtyPZbitGQ_1790069245
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1x8wmm-0004Qn-6C
Subject: Re: [f2fs-dev] [PATCH v16 15/21] xfs: add fs-verity support
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-21 21:45:59, Darrick J. Wong wrote:
> On Fri, Sep 18, 2026 at 01:15:27PM +0200, Andrey Albershteyn wrote:
> > Add integration with fs-verity. XFS stores fs-verity descriptor and
> > Merkle tree in the inode data fork at first block aligned to 64k past
> > EOF.
> > 
> > The Merkle tree reading/writing is done through iomap interface. The
> > data itself is read to the inode's page cache. When XFS reads from this
> > region iomap doesn't call into fsverity to verify it against Merkle
> > tree. For data, verification is done at ioend completion in a workqueue.
> > 
> > When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> > flag is set meaning that the Merkle tree is being build. The
> > initialization ends with storing of verity descriptor and setting
> > inode on-disk flag (XFS_DIFLAG2_VERITY). Lastly, the
> > XFS_IVERITY_CONSTRUCTION is dropped and I_VERITY is set on inode.
> > 
> > The descriptor is stored in a new block aligned to 64k after the last
> > Merkle tree block. The size of the descriptor is stored at the end of
> > the last descriptor block (descriptor can be multiple blocks).
> > 
> > Pro-actively remove any unwritten extents as we use last extent to
> > locate descriptor.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/xfs/xfs_fsverity.c | 363 +++++++++++++++++++++++++++++++++++++++++-
> >  fs/xfs/xfs_fsverity.h |   2 +
> >  fs/xfs/xfs_message.c  |   4 +
> >  fs/xfs/xfs_message.h  |   1 +
> >  fs/xfs/xfs_mount.h    |   2 +
> >  fs/xfs/xfs_super.c    |   7 +
> >  6 files changed, 378 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> > index 525855fdd30d..e62c9a5d0e1d 100644
> > --- a/fs/xfs/xfs_fsverity.c
> > +++ b/fs/xfs/xfs_fsverity.c
> > @@ -6,13 +6,22 @@
> >  #include "xfs_fs.h"
> >  #include "xfs_shared.h"
> >  #include "xfs_format.h"
> > -#include "xfs_log_format.h"
> >  #include "xfs_trans_resv.h"
> >  #include "xfs_mount.h"
> >  #include "xfs_inode.h"
> > +#include "xfs_log_format.h"
> > +#include "xfs_trans.h"
> > +#include "xfs_trace.h"
> > +#include "xfs_quota.h"
> >  #include "xfs_fsverity.h"
> > +#include "xfs_iomap.h"
> > +#include "xfs_error.h"
> > +#include "xfs_health.h"
> > +#include "xfs_bmap_util.h"
> > +#include "xfs_icache.h"
> >  #include <linux/fsverity.h>
> >  #include <linux/iomap.h>
> > +#include <linux/pagemap.h>
> >  
> >  struct kmem_cache *xfs_fsverity_ioend_cache;
> >  
> > @@ -31,3 +40,355 @@ xfs_fsverity_is_file_data(
> >  	return fsverity_active(VFS_IC(ip)) &&
> >  			offset < xfs_fsverity_metadata_offset(ip);
> >  }
> > +
> > +/*
> > + * Retrieve the verity descriptor.
> > + */
> > +static int
> > +xfs_fsverity_get_descriptor(
> > +	struct inode		*inode,
> > +	void			*buf,
> > +	size_t			buf_size)
> > +{
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	struct xfs_mount	*mp = ip->i_mount;
> > +	__be32			d_desc_size;
> > +	u32			desc_size;
> > +	u64			desc_size_pos;
> > +	int			error;
> > +	u64			desc_pos;
> > +	struct xfs_bmbt_irec	rec;
> > +	int			is_empty;
> > +	uint32_t		blocksize = i_blocksize(VFS_I(ip));
> > +	xfs_fileoff_t		last_block_offset;
> > +
> > +	ASSERT(inode->i_flags & S_VERITY);
> > +	xfs_ilock(ip, XFS_ILOCK_SHARED);
> > +	error = xfs_bmap_last_extent(NULL, ip, XFS_DATA_FORK, &rec, &is_empty);
> > +	xfs_iunlock(ip, XFS_ILOCK_SHARED);
> > +	if (error)
> > +		return error;
> > +
> > +	if (is_empty)
> > +		return -ENODATA;
> > +
> > +	last_block_offset =
> > +		XFS_FSB_TO_B(mp, rec.br_startoff + rec.br_blockcount);
> > +	if (last_block_offset <= xfs_fsverity_metadata_offset(ip))
> > +		return -ENODATA;
> > +
> > +	desc_size_pos = last_block_offset - sizeof(__be32);
> > +	error = fsverity_pagecache_read(inode, (char *)&d_desc_size,
> > +			sizeof(d_desc_size), desc_size_pos);
> > +	if (error)
> > +		return error;
> > +
> > +	desc_size = be32_to_cpu(d_desc_size);
> > +	if (XFS_IS_CORRUPT(mp, desc_size > FS_VERITY_MAX_DESCRIPTOR_SIZE))
> > +		return -ERANGE;
> > +	if (XFS_IS_CORRUPT(mp, desc_size > desc_size_pos))
> > +		return -ERANGE;
> > +
> > +	if (!buf_size)
> > +		return desc_size;
> > +
> > +	if (XFS_IS_CORRUPT(mp, desc_size > buf_size))
> > +		return -ERANGE;
> > +
> > +	desc_pos = round_down(desc_size_pos - desc_size, blocksize);
> > +	if (desc_pos < xfs_fsverity_metadata_offset(ip))
> > +		return -ERANGE;
> > +
> > +	error = fsverity_pagecache_read(inode, buf, desc_size, desc_pos);
> > +	if (error)
> > +		return error;
> > +
> > +	return desc_size;
> > +}
> > +
> > +static int
> > +xfs_fsverity_write_descriptor(
> > +	struct file		*file,
> > +	const void		*desc,
> > +	u32			desc_size,
> > +	u64			merkle_tree_size)
> > +{
> > +	int			error;
> > +	struct inode		*inode = file_inode(file);
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	unsigned int		blksize = ip->i_mount->m_sb.sb_blocksize;
> > +	u64			tree_last_block =
> > +			xfs_fsverity_metadata_offset(ip) + merkle_tree_size;
> > +	u64			desc_pos =
> > +			round_up(tree_last_block, XFS_FSVERITY_START_ALIGN);
> > +	u64			desc_end = desc_pos + desc_size;
> > +	__be32			desc_size_disk = cpu_to_be32(desc_size);
> > +	u64			desc_size_pos =
> > +			round_up(desc_end + sizeof(desc_size_disk), blksize) -
> > +			sizeof(desc_size_disk);
> > +
> > +	error = iomap_fsverity_write(file, desc_size_pos, sizeof(__be32),
> > +			(const void *)&desc_size_disk,
> > +			&xfs_buffered_write_iomap_ops,
> > +			&xfs_iomap_write_ops);
> > +	if (error)
> > +		return error;
> > +
> > +	return iomap_fsverity_write(file, desc_pos, desc_size, desc,
> > +			&xfs_buffered_write_iomap_ops,
> > +			&xfs_iomap_write_ops);
> > +}
> > +
> > +/*
> > + * Try to remove all the fsverity metadata after a failed enablement.
> > + */
> > +static int
> > +xfs_fsverity_delete_metadata(
> > +	struct xfs_inode	*ip)
> > +{
> > +	struct xfs_trans	*tp;
> > +	struct xfs_mount	*mp = ip->i_mount;
> > +	int			error;
> > +
> > +	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> > +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > +	if (error) {
> > +		xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > +		return error;
> > +	}
> > +
> > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > +	xfs_trans_ijoin(tp, ip, 0);
> > +
> > +	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));
> > +
> > +	/*
> > +	 * We remove post EOF data, no need to update i_size as fsverity
> > +	 * didn't move i_size in the first place
> > +	 */
> > +	error = xfs_itruncate_extents(&tp, ip, XFS_DATA_FORK, XFS_ISIZE(ip));
> > +	if (error)
> > +		goto err_cancel;
> > +
> > +	error = xfs_trans_commit(tp);
> > +	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_ILOCK_EXCL);
> > +	return error;
> > +err_cancel:
> > +	xfs_trans_cancel(tp);
> > +	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_ILOCK_EXCL);
> > +	return error;
> > +}
> > +
> > +
> > +/*
> > + * Prepare to enable fsverity by clearing old metadata.
> > + */
> > +static int
> > +xfs_fsverity_begin_enable(
> > +	struct file		*filp)
> > +{
> > +	struct inode		*inode = file_inode(filp);
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	int			error;
> > +
> > +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
> > +
> > +	if (IS_DAX(inode) || ip->i_diflags2 & XFS_DIFLAG2_DAX)
> > +		return -EINVAL;
> > +
> > +	if (inode->i_size > XFS_FSVERITY_LARGEST_FILE)
> > +		return -EFBIG;
> > +
> > +	/*
> > +	 * Flush pagecache before building Merkle tree. Inode is locked and no
> > +	 * further writes will happen to the file except fsverity metadata
> > +	 */
> > +	error = filemap_write_and_wait(inode->i_mapping);
> > +	if (error)
> > +		return error;
> > +
> > +	if (xfs_iflags_test_and_set(ip, XFS_VERITY_CONSTRUCTION))
> > +		return -EBUSY;
> > +
> > +	error = xfs_qm_dqattach(ip);
> > +	if (error)
> > +		goto out_clear;
> > +
> > +	error = xfs_fsverity_delete_metadata(ip);
> > +	if (error)
> > +		goto out_clear;
> > +	return error;
> > +out_clear:
> > +	xfs_iflags_clear(ip, XFS_VERITY_CONSTRUCTION);
> > +	return error;
> > +}
> > +
> > +/*
> > + * Complete (or fail) the process of enabling fsverity.
> > + */
> > +static int
> > +xfs_fsverity_end_enable(
> > +	struct file		*file,
> > +	const void		*desc,
> > +	size_t			desc_size,
> > +	u64			merkle_tree_size)
> > +{
> > +	struct inode		*inode = file_inode(file);
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	struct xfs_mount	*mp = ip->i_mount;
> > +	struct xfs_trans	*tp;
> > +	int			error = 0;
> > +	loff_t			range_start = xfs_fsverity_metadata_offset(ip);
> > +
> > +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
> > +
> > +	/* fs-verity failed, just cleanup */
> > +	if (desc == NULL) {
> > +		error = xfs_fsverity_delete_metadata(ip);
> > +		goto out;
> > +	}
> > +
> > +	error = xfs_fsverity_write_descriptor(file, desc, desc_size,
> > +			merkle_tree_size);
> > +	if (error)
> > +		goto out;
> > +
> > +	/*
> > +	 * Wait for Merkle tree get written to disk before setting on-disk inode
> > +	 * flag and clearing XFS_VERITY_CONSTRUCTION
> > +	 */
> > +	error = filemap_write_and_wait_range(inode->i_mapping, range_start,
> > +			LLONG_MAX);
> > +	if (error)
> > +		goto out;
> > +
> > +	/*
> > +	 * Set fsverity inode flag
> > +	 */
> > +	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange,
> > +			0, 0, false, &tp);
> > +	if (error)
> > +		goto out;
> > +
> > +	/*
> > +	 * Ensure that we've persisted the verity information before we enable
> > +	 * it on the inode and tell the caller we have sealed the inode.
> > +	 */
> > +	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
> > +
> > +	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> > +	xfs_trans_set_sync(tp);
> > +
> > +	error = xfs_trans_commit(tp);
> > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > +	if (error)
> > +		goto out;
> > +
> > +	inode_set_flags(inode, S_VERITY, S_VERITY);
> > +
> > +	/*
> > +	 * Proactively remove unwritten extents left by COW preallocations and
> > +	 * write preallocation in the merkle tree holes and past descriptor,
> > +	 * and any delayed preallocations
> > +	 */
> > +	error = xfs_free_eofblocks(ip);
> > +out:
> > +	if (error) {
> > +		int	error2;
> > +
> > +		error2 = xfs_fsverity_delete_metadata(ip);
> > +		if (error2)
> > +			xfs_alert(ip->i_mount,
> > +"ino 0x%llx failed to clean up new fsverity metadata, err %d",
> > +					I_INO(ip), error2);
> 
> We just set S_VERITY on the VFS inoe, but then xfs_free_eofblocks fails.
> Should we clear S_VERITY?
> 
> Does xfs_fsverity_delete_metadata need to clear XFS_DIFLAG2_VERITY?

Yes, that's right. I will look if it's fine to move all the clean up
logic to xfs_fsverity_delete_metadata().

> 
> > +	}
> > +
> > +	xfs_iflags_clear(ip, XFS_VERITY_CONSTRUCTION);
> > +	return error;
> > +}
> > +
> > +/*
> > + * Retrieve a merkle tree block.
> > + */
> > +static struct page *
> > +xfs_fsverity_read_merkle(
> > +	struct inode		*inode,
> > +	pgoff_t			index)
> > +{
> > +	index += xfs_fsverity_metadata_offset(XFS_I(inode)) >> PAGE_SHIFT;
> > +
> > +	return generic_read_merkle_tree_page(inode, index);
> > +}
> > +
> > +/*
> > + * Retrieve a merkle tree block.
> > + */
> > +static void
> > +xfs_fsverity_readahead_merkle_tree(
> > +	struct inode		*inode,
> > +	pgoff_t			index,
> > +	unsigned long		nr_pages)
> > +{
> > +	index += xfs_fsverity_metadata_offset(XFS_I(inode)) >> PAGE_SHIFT;
> > +
> > +	generic_readahead_merkle_tree(inode, index, nr_pages);
> > +}
> > +
> > +/*
> > + * Write a merkle tree block.
> > + */
> > +static int
> > +xfs_fsverity_write_merkle(
> > +	struct file		*file,
> > +	const void		*buf,
> > +	u64			pos,
> > +	unsigned int		size,
> > +	const u8		*zero_digest,
> > +	unsigned int		digest_size)
> > +{
> > +	struct inode		*inode = file_inode(file);
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	loff_t			position = pos +
> > +		xfs_fsverity_metadata_offset(ip);
> > +
> > +	if (position + size > inode->i_sb->s_maxbytes)
> > +		return -EFBIG;
> > +
> > +	/*
> > +	 * If this is a block full of hashes of zeroed blocks, don't bother
> > +	 * storing the block. We can synthesize them later.
> > +	 *
> > +	 * However, do this only in case Merkle tree block == fs block size.
> > +	 * Iomap synthesizes these blocks based on holes in the merkle tree. We
> > +	 * won't be able to tell if something need to be synthesizes for the
> > +	 * range in the fs block. For example, for 4k filesystem block
> > +	 *
> > +	 *	[ 1k | zero hashes | zero hashes | 1k ]
> > +	 *
> > +	 * Iomap won't know about these empty blocks.
> > +	 */
> > +	if (size == ip->i_mount->m_sb.sb_blocksize &&
> > +			/*
> > +			 * First digest is zero_digest
> > +			 */
> > +			memcmp(buf, zero_digest, digest_size) == 0 &&
> > +			/*
> > +			 * Every digest is same as previous, thus all are
> > +			 * zero_digest
> > +			 */
> > +			memcmp(buf + digest_size, buf, size - digest_size) == 0)
> 
> Weird indentation in this very long if test.  Please just put that in a
> separate helper:
> 
> static inline bool
> xfs_fsverity_is_hashes_of_zeroed_blocks(...)
> {
> 	/*
> 	 * If this is a block full of hashes of zeroed blocks, don't bother
> 	 * storing the block. We can synthesize them later.
> 	 *
> 	 * However, do this only in case Merkle tree block == fs block size.
> 	 * Iomap synthesizes these blocks based on holes in the merkle tree. We
> 	 * won't be able to tell if something need to be synthesizes for the
> 	 * range in the fs block. For example, for 4k filesystem block
> 	 *
> 	 *	[ 1k | zero hashes | zero hashes | 1k ]
> 	 *
> 	 * Iomap won't know about these empty blocks.
> 	 */
> 	if (size != ip->i_mount->m_sb.sb_blocksize)
> 		return false;
> 	/*
> 	 * First digest is zero_digest
> 	 */
> 	if (memcmp(buf, zero_digest, digest_size))
> 		return false;
> 	/*
> 	 * Every digest is same as previous, thus all are
> 	 * zero_digest
> 	 */
> 	return memcmp(buf + digest_size, buf, size - digest_size) == 0;
> }

sure

> 
> (Don't you need to compare all the hash slots in the buffer??)

Oh that's neat optimization suggested by Eric, you can check that
first hash is correct (first memcmp) and then compare second to the
first, third to the second etc. to check that they're all the same
(second memcmp).

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
