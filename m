Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4811C5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wIZXDmXe0/YpNd1YLBQ1UOxIZJm5AGk1o2Bo9O8yuHY=; b=U6pyuHdp8pCwxgGWlVzhdYg4pM
	HPQjdq/1/RazRc8A8+RWhc9DMweCdgP39kjc8E98pmBowve/VmGU6TphnOYnOukpdFCW4S1l3lmKe
	Ce5KKAT/dZrrPaOdTGpbIWjGsIEslXlGyTuNIZtr2YaS7qk2ZMadFF1KnanKYKsyF92c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyghr-00066n-Ph;
	Tue, 25 Aug 2026 02:16:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyghq-00066g-ET
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 02:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0BWzbOU5qxkoOhUU4melE2nZy3BDaGobChMEGGofXzM=; b=EhWKaIOUv4NN+s1XVLy11rlzyW
 tIiMD3iiRyWqiKREZUvUSpGv5ivvCpbciknzp1nSpEUZfj6PttWkjlOjNawwqgZvnoZQEQUqc5RFW
 5yEsvPUeG0RMTb73Z1onQSoab+DKm99gBnk6CUHMs3xSlzgSD0vibwas7fspNHx2rjyk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0BWzbOU5qxkoOhUU4melE2nZy3BDaGobChMEGGofXzM=; b=akNG5w0eVVZQc9CsvvdlHua0/r
 I9vIjfyYFTIV3YM3gxqWRnYPiU1PtyNCkQpJXhQPw2fFNNxeGG0ze/oSMmbxRwSBNMW6yP0m29ZiE
 mL4oCxZS5rwNAlTZYMHU1Xgbut0o6YYrCbRZLBgByaqgy92RM1uH1m4d7JtN7uVHOVt0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyghq-0004Wg-N2 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 02:16:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 55241402C2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 02:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CE81F000E9;
 Tue, 25 Aug 2026 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787624161;
 bh=0BWzbOU5qxkoOhUU4melE2nZy3BDaGobChMEGGofXzM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=lDJn1EUwk7Js07/NUOz6YOrG7Qa094WRBLh4PJdaSo3SQ3W6y1BQy5DEpjXHDP2nw
 v3OKnMoSE2M0lmNpssmy61nhTIk9eXs3xgcHyXfainGL7/ktZWiPodsG11CWg7X5n0
 Jv9JbFqqZT41G5rP4CqrZigYtLr3wFhSTGj1Wc2KtpjuUBAMSTxZZXdlfXYSFdwHDj
 V0wji/DVlbPp6R/M2WUS9I3GDIPr5+bDwOG/I1PrM9BnXCVZWZhusc40rOntLyaUMi
 hT/NlvGIjFKC5rvXHtL7Q7DsEDcTrInR3ErsImV+bcKCwnpdxgSzfIST5tsPwSjHNH
 0diFoOQlDuDug==
Message-ID: <1f2d21bc-4b06-471c-a06d-faeebf76a525@kernel.org>
Date: Tue, 25 Aug 2026 10:15:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com> <aoylp9llX9zlKm-g@google.com>
Content-Language: en-US
In-Reply-To: <aoylp9llX9zlKm-g@google.com>
X-Headers-End: 1wyghq-0004Wg-N2
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't leave the hashed inode while
 it's unlinked
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/25/26 04:12, Jaegeuk Kim via Linux-f2fs-devel wrote:
> f2fs_symlink()
> 1. f2fs_new_inode
> 2. f2fs_add_link
> 3. write_being|end to fill the symlink path
> 4. flush dirty pages and or checkpoint
> 
> Step 4 is nice to succeed, which doesn't become a reason to roll back
> the created symlink. OTOH, if we get an error till step 3, don't leave
> its dentry and its inode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

v3 fixes generic/233 failure, looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
