Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9184DC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1iEnnya1bO7M/UKuXvvtSb+2gKtjNTZvqtbILX6z+2s=; b=GMyWE81t1tgIwDXtXBdiRPusSJ
	iCSUoHgxlCyYeJFy2Qal84cetFMNWMBztboENNJDfXkpyMBpMW/4/lfc6KOVqnm+YPDbKXHb9M2F8
	rZiszAp1EzbKSshjTHX39FJpmRO8iThh0ztQdY8P7p2eudjg12xmIxD1NrIYb1WbJilk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2JWF-0006gg-4J;
	Fri, 04 Sep 2026 02:19:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2JWD-0006ga-6C
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:19:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zKKWz3YBAzRZ48fG4niTMaQ+b+q86yK1j5H17drXCQ0=; b=AElqLMC5q8DIWXk1Xn7cQm4lDt
 zIb/zT76HN3MPMJQCT8U+jVggqlaipvWi5rAaJMjgZ/ieysGZq4Gaj5RHW+YlI9y7BukCQXNZ3QZa
 6YvUrfkpwzqf+eNA++EVDjgzAJSCGAVJtlOeLW8pnuTA23RphkOdiNzM1oN3ca2r1VMs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zKKWz3YBAzRZ48fG4niTMaQ+b+q86yK1j5H17drXCQ0=; b=FSAa9Mo5uPrUFPn2c0nhjLAMie
 J2LMMJSRwN9yaqPau5iBo+8p3Qjgo4KVEvVm73vGsjo38xEEruNUwgEtBGs9FTDRrKM7S/Sz3gnZX
 f47As8TASunT2gcyE1j9HFUljHPZy0Pqp5cxNXvm1KRF41NGiChqa+EW4XpiNGU6H8JM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2JWA-0005nK-Ih for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:19:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E971160A62;
 Fri,  4 Sep 2026 02:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5782B1F000E9;
 Fri,  4 Sep 2026 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788488336;
 bh=zKKWz3YBAzRZ48fG4niTMaQ+b+q86yK1j5H17drXCQ0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=F4ZRnbu7gsjzTFY1903nrBKYxOWm3OaqozwOX8npEqxvtsSH8GZf42YpDe760hGTh
 7JIY2pryIjSAaAAlGalY0g3IroJasFNUpDYs8ra/I2oByB89HQC/UdiF+sruCK52rX
 X2itS3fSCP/B71m2xIR7XGxmA6Ij4UDuIqPuqkz7+czhleyHsOjzHHl8hFjDU8UtVj
 BtExl1rUqkLq3HI7OSvDn8lVNE3JjBDHk7sbM8uO5RMCxWSq80hYymR/vQJkynggeH
 nEarE9VhvsiNpKzt5jFe2TQsiO3xdSvA+HNQ5y5YevXv7JtFCkI+UUSHlVm3ZOciJu
 g+NYFhPe9QFNw==
Message-ID: <b9851d18-b0d3-4b47-a889-e345d78a79e4@kernel.org>
Date: Fri, 4 Sep 2026 10:18:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <04bf8eb2c833d8fbb767558c49b53c715f6698b8.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <04bf8eb2c833d8fbb767558c49b53c715f6698b8.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2JWA-0005nK-Ih
Subject: Re: [f2fs-dev] [PATCH v9 10/11] f2fs: describe node tree geometry
 dynamically
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
> The file indexing tree boundaries separating direct, indirect, and
> double-indirect node blocks depend on the number of data block addresses
> and node IDs contained in each node block.
> 
> Parameterize index boundary macros (NODE_DIR1_BLOCK,
> NODE_DIR2_BLOCK, NODE_IND1_BLOCK, NODE_IND2_BLOCK, and NODE_DIND_BLOCK) and
> address capacity helpers (DEF_ADDRS_PER_BLOCK, NIDS_PER_BLOCK,
> cur_addrs_per_inode, addrs_per_page, and addrs_per_folio) with
> struct f2fs_sb_info *sbi.
> 
> Update file mapping, block allocation, truncate, garbage collection,
> and recovery paths to compute indexing tree offsets from the runtime
> geometry.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
