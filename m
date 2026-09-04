Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9B2C624DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFtzOfYoPYD7tXFvGSat+ibBUb5L9WLlIuZOAW2MGmg=; b=d5Vpwf41egAPW2NWl9qoU7Z5L1
	jQAotl0XzveVaFYSsRn+NCr0oL9TwyzbCFoO6vbRApr9PS4XXkz0CmbpfWz1Xg479Aj038X/e7ieb
	0Jy+WeBLk1RK4v4jmPn4EowGi9VpB5w/DAUOP0bRom6FEQ2jkr+2JQnFg4qlRIwotStw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2J8A-0006bQ-JU;
	Fri, 04 Sep 2026 01:54:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2J89-0006bJ-8G
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:54:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1WRoLVevLW92ZIPX07qRkQmYsWzRclwhzP39wqjr+bk=; b=TMZ4OaDbz70FbuJORFHCsftAms
 nb2D7oIRx6dGkeeD3uLNtJX32qu3ewX/ypfO7CmjAge3fkZInyIv0vbdHa+/lh00gptzVTmRozJxF
 hi22se2weppwJkLcRumdEasQZuJVvAQxHcOp7hnleM2yDUSpcHRsCPhLpud810h1VHLI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1WRoLVevLW92ZIPX07qRkQmYsWzRclwhzP39wqjr+bk=; b=mOJGnDBTTTcDhd4eVcz2wyPPAZ
 Q5+afigPH+e2hOINcVS+dqh1S56x4LRwOmMlDSfLrkfpFufLSstKfNL4MbtNRE+j/U4NyXynEt7np
 T4a5LAX0jW70rJ+2QnSKmrwSnIN9BCVO/5rpo83Ilc6ltGyDKOVqlvemb4Llffo0USvs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2J89-0002oE-GW for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:54:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C049F436F2;
 Fri,  4 Sep 2026 01:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBF01F000E9;
 Fri,  4 Sep 2026 01:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788486847;
 bh=1WRoLVevLW92ZIPX07qRkQmYsWzRclwhzP39wqjr+bk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=CMKUXVIcZ6FuF1ROV9ZJT6R2Q95SSvruGs49Sv0hA7bSd9RFkNWYiUAgbV58voFZ+
 ke9r38PWwkptBTb2GMHnsS27+jbFh18HhTR+fWi5/jnMkfMekFhw97UEMOUUP5U5mT
 6CizXrmkEBH1vUD4zW47IWTn81OQQCuSswXSkxN8xxhICylz41H8ZuQtEbk7tGjEyv
 W/sZl4/7LCnSmIIsrPkoYZDU8dPBqcG+3T83nm0hIxFMvwsgY+nShDflqc35v9hlE2
 W8/j8eLUFh6rCLOd2UnrLfVGgKAEcCgwdzlSIMyr2egr54Fin9anhZaA9ZYtPvd/1s
 PfSu0ih6WO2NA==
Message-ID: <b4b114dc-f161-4759-b508-3d34519a041a@kernel.org>
Date: Fri, 4 Sep 2026 09:54:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <10843e36038ce78374ef20fe8c19f6ec392bc078.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <10843e36038ce78374ef20fe8c19f6ec392bc078.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2J89-0002oE-GW
Subject: Re: [f2fs-dev] [PATCH v9 02/11] f2fs: describe SIT block layout
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
> An SIT block consists of an on-disk array of struct f2fs_sit_entry elements
> whose total capacity depends on the filesystem block size. The existing
> fixed SIT_ENTRY_PER_BLOCK macro hardcodes a 4KB block size.
> 
> Convert the entries array in struct f2fs_sit_block into a C flexible array
> member, and calculate sbi->sit_entries_per_block dynamically in
> init_sb_info().
> 
> Parameterize SIT indexing helpers (SIT_ENTRY_PER_BLOCK, SIT_BLOCK_OFFSET,
> SIT_BLK_CNT, and f2fs_start_segno) to take struct f2fs_sb_info *sbi, and
> update all call sites across segment management, checkpointing, and mount.
> 
> This is a layout-only change; valid 4KB filesystems retain identical
> runtime geometry and behavior.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
