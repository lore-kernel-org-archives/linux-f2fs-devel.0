Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B35C55182
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 01:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ax3wYde3fE+te0gNCLvWUc4e7hG9T4GqZzmz2R6EeXg=; b=JYVILPyswUSzGCOlJnzbMXKdYG
	/oEXuX/j/nW+ig8w9pY6JQ6JlfO2GOJK4HFF0jPEINj5ANEySaU3anB9A17YmESld3lN+fljk+t8d
	kNU624wcuDkpAYV3LKysl8DtoI5xNQC8sgOENb9teA+yTIZek9pgvUEFyoBT/ORoVQDE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr3e3-0005j4-S2;
	Tue, 04 Aug 2026 01:08:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr3dr-0005io-5N
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 01:08:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oO/QqiHM5COrVfZG+imXes33nJ7bxHczWxw9WoEHN3c=; b=EvBDMGI4zkVJLuceQvHrf31hiq
 dpDPRIVdOzeVdTH60q8pt7H2toGgrl0s+/4bIO2LKCWggh6yiMeXeGCn4X2RT6AacQjTK4sEj6NdB
 raPQoHjJu+cPe02sYLnsL3mrlx6GP168SwWnMTfgjBg+A+Lvt/DXgKeEXCL399zAOguI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oO/QqiHM5COrVfZG+imXes33nJ7bxHczWxw9WoEHN3c=; b=jhzEzLR/mvhJSflWGwfTlQqFF5
 Qq1tQgDNe1h3JMxdLvAVoH5n27TEjhD/KekZnCaeiqDem4cPh+kqfJfxbLtfpfWdkNLwtbKA7a7Qj
 df1yfss/3QRNk1HFxOYaLAaJHzqCq/A3I46JcNrL8Chfoia5X6fyCXXTH6dx6A+j+BW8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr3dp-0002kp-TX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 01:08:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4384760A59;
 Tue,  4 Aug 2026 01:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87EB1F000E9;
 Tue,  4 Aug 2026 01:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785805696;
 bh=oO/QqiHM5COrVfZG+imXes33nJ7bxHczWxw9WoEHN3c=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=WgJtHwk9SCJ5b6fwh5xtUMdYnQITCVxX9mq1acJTmBnFbQIw/xxu8PtQkktfmvxoz
 HuMOfmaX3dXuARiIWxgXF6diqtbdkfNADGNF2Jp6LTV5SN+mHqHTZcDHuPCx6CC53i
 7FXBFPwurK0pAJBsBdgne9JJhmAFdXrAF5nghPMEeGpDlTfUJpvlDkONQSZsL+ffKP
 Ittpf5mMPhgvC+jq1xfvG+QUevSlG2b4DKgviaYB2xjFagjYDSpKUCZhSTEBbWossW
 ZHm3+2q3CKCN5dT0kIV5obeZMn8l+Aewr+AFpDuy/0zNv2eAiUoG76BW/vJvk3fgEz
 Gijm6Ob86a/Hw==
Message-ID: <6229b2bc-3167-410f-a1ad-659aaab07928@kernel.org>
Date: Tue, 4 Aug 2026 09:08:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Changcheng <chenchangcheng@kylinos.cn>
References: <0b450e92-b9b0-4a55-bd16-ad106245d7e1@kernel.org>
 <20260804005402.13026-1-chenchangcheng@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20260804005402.13026-1-chenchangcheng@kylinos.cn>
X-Headers-End: 1wr3dp-0002kp-TX
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix valid block count leak on data
 block allocation failure
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, ccc194101@163.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/4/26 08:54, Chen Changcheng wrote:
> In __allocate_data_block(), when allocating a new data block
> (dn->data_blkaddr == NULL_ADDR), inc_valid_block_count() is
> called first to increment total_valid_block_count and i_blocks.
> If the subsequent f2fs_allocate_data_block() fails, the function
> returns the error directly without rolling back the
> already-incremented block counts, causing a permanent leak.
> 
> Fix this by calling dec_valid_block_count() to undo the
> increment before returning the error. The condition
> old_blkaddr == NULL_ADDR precisely identifies the case where
> inc_valid_block_count() was called.
> 
> Fixes: 7d009e048d7c ("f2fs: fix to handle segment allocation failure correctly")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
