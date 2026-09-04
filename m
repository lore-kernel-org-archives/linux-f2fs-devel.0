Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC78C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJdHD4WJkTOBtoUok5EhEx7G5Hvre/WbhiZ/ax/HSvA=; b=eTfH3Q7wOHDys2+xmizjUtoQU0
	TJGQgjk+i6sA7PXkAOStKuiRDSPpfpR+OoNplGi3IfWDlYso6gWZ82eaY59pAAH1bbmiaO+0FknJk
	HIf2PM9KAjLevbylQlSq4693TlKrHcKScPFOIBtqnq+d90kIfqNaOaKL5rEuNtPMRfvw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2JXx-00050M-Dn;
	Fri, 04 Sep 2026 02:20:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2JXw-00050E-6U
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IwGKthmt4E7m/+iMAbRiXr2czfrqG8wwf4OU88unG0Y=; b=T5EdH3T4pCqvYWZaOhVeZ9NQ4B
 EVqharBFujvHRNW00ABb+2N2GKjjiuDXCpwbbjnGPnRaICNg2sO/3nEDbY5/EXVJXcL9XwiV8M7np
 RrURPhibuSmS7MzxvrlGZtP0oTbgrRb873ius8vjiIL1mPGp421v8sVhex/GExCPz4go=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IwGKthmt4E7m/+iMAbRiXr2czfrqG8wwf4OU88unG0Y=; b=X30LfoUtQWvAldOwttgwwnuCqV
 U1lHu8F3l0EX+GjVn+n1fMqhNiY+sg8sDdr3nu8MJY6sxJHR132BEVY7UQVHdrjNgxA2jDlMiUHFJ
 DkGJq/FDkN1rtzB2pZb5+nLUtVwZ4NawNx4FpQgHe7aYbr8wAmw2zl4QnCIO0d50tVC0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2JXt-0005qh-9Q for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:20:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DBC4B41531;
 Fri,  4 Sep 2026 02:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B82F1F000E9;
 Fri,  4 Sep 2026 02:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788488443;
 bh=IwGKthmt4E7m/+iMAbRiXr2czfrqG8wwf4OU88unG0Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=OYJnDsqN+TjSFFxCZlGrNoRHpa7/s0E5f+9hSaXcA/cvHS/1KT0V2zkKQNslI4xmW
 vC1mBLg5roIKpMa7YMj0s9a3Ml2HyhQRDgXFFb/pV4BuSiIhB6etObzl8pVWUNMSJB
 S1cEdwxhDYKPSuX0W5EJIyv/I81Ln85rwpxNuTUl+jwZZQBXma1KNr1swDeOejkIzv
 5R9pZp3W8tGK/HZaLL1Bf0WX3hywfwL6qJebpBOLiuU/zWO+WOcIfAKjIaRIpZIh2m
 YOMKvw3uRx5Tr339CzRrFyRD/cz8WN8zBaw6Z32siuL9KAwrGRf+PtlJ90bXoTpbq+
 yaFPrcDUqUrlA==
Message-ID: <08d8d137-9e97-4c7c-ac2f-757539f921e1@kernel.org>
Date: Fri, 4 Sep 2026 10:20:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <a8360fd9da798b19b33ef577b7af0ba594db3eae.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <a8360fd9da798b19b33ef577b7af0ba594db3eae.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2JXt-0005qh-9Q
Subject: Re: [f2fs-dev] [PATCH v9 11/11] f2fs: parameterize block size and
 mask macros
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
> Block size constants, shift counts, masks, and page-to-block ratios were
> globally defined assuming a fixed 4KB block size.
> 
> Parameterize F2FS_BLKSIZE, F2FS_BLKSIZE_BITS, F2FS_BLKSIZE_MASK,
> F2FS_BLKS_PER_PAGE, and CP_CHKSUM_OFFSET with struct f2fs_sb_info *sbi
> to reference sbi->blocksize, sbi->log_blocksize, and runtime masks.
> 
> Update call sites across metadata operations, data I/O, file operations,
> garbage collection, inline data, and sysfs information.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
