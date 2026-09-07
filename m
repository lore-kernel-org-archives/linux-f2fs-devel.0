Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7187BC79F89
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pG2uXtl6n0NpY6kPbuHOk/Vdkg9h3oCGErUnp+DlEQ4=; b=O5L9Jrzt5ZCAcg3l46PSnDjROG
	9X5mfF2VSrwUFyXAUWzKs15lU2rTkz+zxlmjv3v8VgL8Il5dsEFLtVEZZps33Xbes6boGoV2mgO4p
	/43XIr4xx1DheNZplsy02yiRIvtaR2XjkHRvH+FD8CcRMwLTGkoK7533olWM9UCGbHso=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3TSk-0000Dr-JY;
	Mon, 07 Sep 2026 07:08:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x3TSi-0000Da-OW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 07:08:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jlbStKHa4bu/HI+nH1MbHGi1dimJr2VIkH2sCL9mlCg=; b=hyuA1ojIcaD8mSen8tsTeSCmZR
 Cs734F0/BffRGTeYAZ80vB3MO5H2TtCArXUHKqx9iC6xufsCQZjI/oji4v2mO5CIk3F149yyDIIwO
 bs965GF/zXwswjM5qM61a0eCIMRFEQKMAffKe3yYLk3RuwvWlRskxPsWrHWtP5fh9ouI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jlbStKHa4bu/HI+nH1MbHGi1dimJr2VIkH2sCL9mlCg=; b=WHhAY+RMmwN6BUrIZu8Wu5E5fK
 rY11+eq8uf2fbSuCDxbW+yiwTZthQWbz+VdqWEQocBVEzii1egFQcIQfys9XlBjhVcYPDKwV79+Pi
 smKCUS0N/7q7uPxt3ZSZ5w6evNTsrcenFaHSPg67q7ZuJcI3l5txUQi84UC7oqacZvik=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3TSi-0003D9-45 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 07:08:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B8E6601F9;
 Mon,  7 Sep 2026 07:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682261F00A3A;
 Mon,  7 Sep 2026 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788764890;
 bh=jlbStKHa4bu/HI+nH1MbHGi1dimJr2VIkH2sCL9mlCg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=WrANjgRy5WetVSw6VH9tLJ/rYoxdMbPO3vHRnoKSLFjfNs5x6w32qZ+7/CJ+lCALc
 HELj3bPW0/Sx0/P/KzoC52NOMmvi14R3TE5qkUv4DGMudxDyLsrzka0qi+hoGL39Hd
 2LpONCYZSsHw25wSmF7tyKcm8lUnHOR88FaIfM48AOpRyc9KYOjgjvXmGXM0Nu5tSE
 GgS1UnyAwKTzCKheFCvA65hw0O4ifO4GPnLeOEgAaEyCX+C9J91BoLIQs9iubsdQ6e
 9RncnI5z/XovW3oxo9hDEhZYzrtGUSwcyLlAtY9ag3aO8wlMpujAI3eBxcJSzQVAMR
 ekht1oDj+FJ8A==
Message-ID: <b90c9052-b44b-404a-85cc-8221249b63d7@kernel.org>
Date: Mon, 7 Sep 2026 15:08:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jiucheng Xu <jiucheng.xu@amlogic.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <5de3d9c8-e847-422f-a9e4-31ac2a1b5c2e@amlogic.com>
Content-Language: en-US
In-Reply-To: <5de3d9c8-e847-422f-a9e4-31ac2a1b5c2e@amlogic.com>
X-Headers-End: 1x3TSi-0003D9-45
Subject: Re: [f2fs-dev] =?utf-8?q?=5BPING=5D=5BPATCH=5D_f2fs=3A_force_out?=
 =?utf-8?q?=E2=80=91place_update_for_all_writes_on_compressed_file?=
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/2/26 11:18, Jiucheng Xu wrote:
> Hi f2fs maintainers,

Jiucheng,

Sorry for delay reply.

> 
> Gentle ping for this patch:
> Link: https://lore.kernel.org/r/20260826-origin-dev-v1-1-c21271a82100@amlogic.com
> 
> For compressed file, compressed write may fail and fall back to raw
> write.
> If in-place update(IPU) is allowed, raw data could be written into disk
> before cluster metadata is updated from compressed state to raw state.
> Sudden power-cut during this window will result in inconsistency:
> raw data on disk but metadata still expects compressed content,
> which causes decompression failure when reading the file later.

I didn't get it, can you please describe the issue w/ call stack in race condition?

> 
> To eliminate this risk completely, force out-place update for all
> write operations on compressed file, so IPU will never be used.
> 
> Could you please take a look at your convenience?
> Any comments are welcome.
> 
> Thanks,
> Jiucheng
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
