Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6736CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2026 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kDGBV1wG1Da26OMAtGTtIaZ4ZKZTpqi2ntMJiK3i3C4=; b=alWEEjt7HNipgc5KuN/gzDD+n5
	XmCDDR+4KTft9SVGGzuQt7ZDX6CqxSsKUwZB066Mk6zEPc1LAJ2pGBI8j+h3G6SrjbaE5sa0TtLs5
	2LW9YzXWYEqLrgyZtGfanoVL/gEtxzFfzTcvHcWJ8NEGc0ZEADwe3fC/23r9XgNEjyZ4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLdSo-0006x0-Pl;
	Sat, 09 May 2026 08:55:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wLdSm-0006ws-1n
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 08:55:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dBaJhREcNtiZRaLFdl4M22ehN9+eEDfpNihfs+jNe2o=; b=grAhxMuzsUWaVp8VwmYoBOholu
 bQUcGRYfzetrBc/JjfYdIgXOmAepMOixHADZexZlfRyFJTVpcMl9ElMeM4biGuhauJ6mT1DKl6anV
 EPxHsHOhXvde6GXeDLh4thxCAPRtHrvrOo5Yw1HE3B1NGArJtrIr02VrWIq8OSaimUtE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dBaJhREcNtiZRaLFdl4M22ehN9+eEDfpNihfs+jNe2o=; b=M5Zf0lPro87+wIGTsE/FUBU5vB
 apO0oH2EHUq0AnTlfjs3nJS1aoqu77vxs93OgauhfU2WuFoVAyfQOawOVXiKyOsb1rsIkAAFqW8bd
 k205Lc0wyQAAVCD8un7ss72sPisqVD1ZC76ytgAZuQkVhdkiqlhHE9bd0bJt+LPsPlm4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wLdSl-0007ER-8t for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 08:55:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F08D3443F2;
 Sat,  9 May 2026 08:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513EEC2BCB2;
 Sat,  9 May 2026 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778316901;
 bh=eniuNTVh2p88dTOp+vXhl/Hd+3qw+2vKHIX2242kSiA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=b2KZLCFXW5SALa+eYQayULmN6FCutAIYeoUZizFBRsI+qgYOPvBnVqOOWNlVc5kF8
 8oVyn48+WThSVzjr8LvVzEYyU3a26ZQpuflb7mSmrIg/cqMNbAHTpfGYtcThMONjin
 5SIyrYX6PSq31UP24bnr0rb9LzZ+DOgu4f+OqNIz+2ORRnlRs1PYWTk/qYHZyWZzSu
 Cu29aYQvb/guagOojk3c2+jtS1bvAzMMuFzSI/yOq0Tu6z+V/TxYpdJa22FQHHsRvv
 3p0yQB2Z6z+mzbeGoxiId/hi6SsOE2p0lM4pzpXI5ydYEV1mwI7PRb+PNhF5uUCBtz
 zVt+mhSrLUsrA==
Message-ID: <1f22d0fa-c277-40ce-9bb5-413ddf52bba4@kernel.org>
Date: Sat, 9 May 2026 16:54:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260506095731.1039356-1-jinbaoliu365@gmail.com>
Content-Language: en-US
In-Reply-To: <20260506095731.1039356-1-jinbaoliu365@gmail.com>
X-Headers-End: 1wLdSl-0007ER-8t
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: Add trace_f2fs_fault_report
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
Cc: shengyong1 <shengyong1@xiaomi.com>, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/6/26 17:57, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> Add trace_f2fs_fault_report to trigger reporting upon f2fs_bug_on,
> need_fsck, stop_checkpoint, and handle_eio. Since f2fs_bug_on and
> need_fsck can be triggered in hundreds of scenarios, define set_sbi_flag
> as a macro to help capture the effective fault function and line number.
> 
> Signed-off-by: shengyong1 <shengyong1@xiaomi.com>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
