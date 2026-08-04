Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C48C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 02:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=segessSckpRvNmDw+b0dJAo0HUOlTVZse1ZMwVZ+vjQ=; b=aMnYKoZ/0vDSEc2jH7YQxXhDON
	6G3t9C9MO+YafkcX374X+qhE72RFTst2EuFkZ8gliKISWHVwlkRahwaQaJvlCb0jjn1+oX5onerQu
	Ly7oEw43t2w1cLkuGj4lk0jw9/iyvdkAiVMeTfW141Z+s0jgI8tXq/8CTm+QT9YIyFM4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr5Jv-0002O8-OM;
	Tue, 04 Aug 2026 02:55:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr5Ju-0002O1-8t
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 02:55:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9sMXVCVRu6HkzwiLjNbUtN5xbg/2Po9gPBpf4aBtlhk=; b=F+IwusQHMfH9PnY4jBdiWh/4MG
 YBGD01ia8DADhNyzAD3nyD7qdleCLY3ktXWMK2u3eGBz6RSta15muapGaPCoRkE6wyeEXVI1c8Z/L
 aK7VZbUd25cHKItq4bEuu6YwLfe4cvj44Ls/z5F8I3nKSPuPRFe2D7DvAEY92UqphrsQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9sMXVCVRu6HkzwiLjNbUtN5xbg/2Po9gPBpf4aBtlhk=; b=ZY9tc2lZYAcX4PMA+sz7Ihbhfy
 i12b74QqVhC6Ig4YwhmNekNcmegfdHicGZ+xRbCGDXOglo3+XjM04t093VxcqJuC0fvCcO/CxryhB
 UwJKo4W5DuLr+d6PFOhqlN18hUY/2ufuBDDeQ6nX54Jyo4yj3FqMcqcYL2LPcYO8dz9I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr5Jr-0006XJ-A3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 02:55:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFBF54051C;
 Tue,  4 Aug 2026 02:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2FF1F000E9;
 Tue,  4 Aug 2026 02:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785812149;
 bh=9sMXVCVRu6HkzwiLjNbUtN5xbg/2Po9gPBpf4aBtlhk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=IbsyfEhWdyJwXHx+q52Yuu987fYew+OPeVwIks2N2vWLlIOfZ2/xzZWREYj5cWTYv
 8SiGu/dw5pX+wlkZebD80zk7A/Tu/P1ZcU6lSCVhgmDpBX8YhgWRoDWt0ITrMt0j/4
 18QXYy2OLUNryOkuFv/bp6jSTrgbn03adcminAm0iTX4XUCq/lr7VHJGef1OPIrHYf
 U0m/fOCD+abTL2UbmYJgUF4E++rwXCCi0ABSgbbvK5hsKReZnpBv5ClZab/zXrM3Z3
 hqinhb1VuOOUvLz6xFLPzYZhRwN419HEYJIj09WZrOM6mygJ0RTpd631NcXdkTsYwd
 TMgwigcSzeS1A==
Message-ID: <81d7efa2-8e60-4f92-9cf0-613f6116756c@kernel.org>
Date: Tue, 4 Aug 2026 10:55:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260804014849.1942326-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260804014849.1942326-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wr5Jr-0006XJ-A3
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: avoid NULL checkpoint thread
 access in sysfs
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
Cc: linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com, stable@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/4/26 09:48, Wenjie Qi wrote:
> checkpoint_merge can be enabled even when no checkpoint merge thread is
> running. A read-only mount is one case: f2fs does not start
> f2fs_issue_ckpt there, but ckpt_thread_ioprio is still writable through
> sysfs.
> 
> The ckpt_thread_ioprio store path updates the saved ioprio value and,
> when checkpoint_merge is enabled, calls set_task_ioprio() for the
> checkpoint thread. If cprc->f2fs_issue_ckpt is NULL, that dereferences a
> NULL task pointer.
> 
> Protect ckpt_thread_ioprio sysfs writes with s_umount as well, so the
> checkpoint thread cannot disappear under the store path while updating
> its ioprio.
> 
> Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
