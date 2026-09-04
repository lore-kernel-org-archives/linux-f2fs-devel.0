Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEE3C624DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANws6xvCfAgfBKxHXYCTbLLtRyW5Fugk+SNWsN+E1zE=; b=Z0m1wY5XOg01rcITx5h+nVT8SQ
	fnhiOwRBlxTSlXnkxkBdUH8/tvko8C4kVHt9WdunuOWcXkG5sXDZZc9dITNF1v5nRRD5xi04f8gFL
	mLiQp5D2ld+MJYZRoYLPZPXDjgzaJE8qfD7m6RthiGSZIGBvL7H0vFWjLhdRMvev8AdQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2JMG-0006tO-Gv;
	Fri, 04 Sep 2026 02:08:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2JMF-0006tI-GH
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:08:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JpIiM9RS2dPe3RJ8h8GSK+A1sWoqyWBVYAWp6xcIy/g=; b=DXBrxRgSKlAO/0OvXhAk+Fz+Y/
 r2bdZqQqkFlWyy4UHmL1+h51TbRVvRw13ysnoP310lKl852ubou1CcwQPFnvZg7nRdV3guNCIiCVR
 YKfmontkAkdVHzrdhpP/riQ37qEle7jQH/uMQNN4RiqaAR7xUy/MvqPMNHTH87NDj3EA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JpIiM9RS2dPe3RJ8h8GSK+A1sWoqyWBVYAWp6xcIy/g=; b=UG1cEXGKJ3eIj36tfDzqRkpQ5A
 1lPdUBVsV9nCBxJRXgJ+ZRJuHy2AN4FVviuhAo8IEBn7RordYM2e9XKOqYQvGrE/Ieu3cYUsLPLgx
 Z3btm3lEBoKFCKkaQE9CN5PI1O8ZOgv109yJU4nKTSFAA5gHxyCrk4XsAmLKoNlWpHpw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2JME-0005VJ-QR for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:08:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F12760234;
 Fri,  4 Sep 2026 02:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE731F000E9;
 Fri,  4 Sep 2026 02:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788487720;
 bh=JpIiM9RS2dPe3RJ8h8GSK+A1sWoqyWBVYAWp6xcIy/g=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=WraHOTd0ni5zX/RAWl3FqmsDt93nLAbQxA4Of+ciRMiFINODuH4Y31Y16Wqob618X
 Fh2mCeRsehEgmbNVKXB5hc4LLhsXag/yfu0ACiDRuwEhZLnQuehFbNrxuGms3d8Lbr
 Ng+T9RsRmXezL/dxF98u2lZmMgxyVDn74O+966bA/D2NDnLlA8gHMXO+rq0m7cajCg
 bDpCTO263VkoH1VQdkDiUsas4F8CNTh/+JXNfVz42Sk27LGDoHofVOgJ5AL9cK+U5M
 tW0C6JqP/Q1Ps8PPT1Z1nIhsRfsEbM8g8fQ9Jp5+G6PwepfyCVZy3PXM3d+78IlLy2
 k+Gxd00wr+TMg==
Message-ID: <0b8576fb-684f-4540-974c-5bc36ceef6b5@kernel.org>
Date: Fri, 4 Sep 2026 10:08:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <fa4246935a75c0c08d91dbf082464556bbb47d43.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <fa4246935a75c0c08d91dbf082464556bbb47d43.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2JME-0005VJ-QR
Subject: Re: [f2fs-dev] [PATCH v9 06/11] f2fs: describe {i, d,
 id}node block layout dynamically
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/26 07:56, Kelvin Zhang wrote:
> An inode block ends with five i_nid entries followed by a node footer.
> Data block address pointers (i_addr[]) precede them. Similarly, direct and
> indirect node blocks contain data addresses or node IDs followed by a node
> footer at the end of the block.
> 
> Describe struct f2fs_inode, struct direct_node, and
> struct indirect_node using flexible array members. Compute the locations
> of i_nid and node footers dynamically from the filesystem block size.
> Introduce F2FS_INODE_NIDS() and F2FS_NODE_FOOTER() helpers to access these
> tail fields.
> 
> Compute sbi->addrs_per_inode, sbi->addrs_per_block, and
> sbi->nids_per_block in init_sb_info(), and update node management, file
> mapping, and recovery paths accordingly.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
