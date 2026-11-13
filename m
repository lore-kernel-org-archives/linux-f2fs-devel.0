Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18641606A339
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b5skYwl/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bpSBA327;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DRmpIsia;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkevgVD3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Nw0DfqO0UgWaLGtZ0KGp51lylmF8XYwwFwXtb49HgR8=; b=b5skYwl/+r/FeS
	vZPZF7bY6+9gj+Mstt9zg2En2MLpCEpMuVKw29zDO1+GAukvkWpasusBPChdk1R7OerGlqmrm6AY9
	mtHxUottwLN/yAfEULmpq3u0evlk4FzSki7dCrKWyj1GicA3E+RjuvG+M+WSCUzOR/o5B6JXqICGc
	EnA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRnd9-000000006GD-1OfE;
	Fri, 13 Nov 2026 09:31:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xRnd7-000000006Fs-43oI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:31:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U+T4uJ/e8/uh76kjQ5Uc9g/ybxEFK3XIJAOLTkG2Nds=; b=bpSBA327KTYKcV/8v1ftlvDYx9
 UXQnR5+Mg5Kqwq4ojTsS/9w5r/tpdAn8zKeKkrzbesnEwNIkRilik37sXoEBEaFOeWnIO3TbVazok
 JoqO+Px2UCz6qTcegQeXez5t8KYbxO+zP+CX/UiucaQ8Y7JW1qul0GikCwecaP2vA/J4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U+T4uJ/e8/uh76kjQ5Uc9g/ybxEFK3XIJAOLTkG2Nds=; b=DRmpIsiayaod1yrTkBYepFKIK6
 WWetYTAhadHRSlvxodYl9aOPeiG+echTayjMTOI4wmVN5QKoERjJOT85roky3o4A530SZCc+vK1Rk
 EtVe2oAa5zF9qb1r5e7dQ73v+/Rm/bZzZkpbEa0b9Rq9xF/QXDz1X4UaM9Mf7xuHDoE0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRnd4-000000007cE-1sEt
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:31:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B51342E29;
 Fri, 13 Nov 2026 09:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68321F000C4;
 Fri, 13 Nov 2026 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794562285;
 bh=U+T4uJ/e8/uh76kjQ5Uc9g/ybxEFK3XIJAOLTkG2Nds=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=SkevgVD3y0KBQDFc35+Xm3Vp1FTWw7yzvBaNGH5AIIsVODesjyHZvCjMr89UoeGXq
 L4pfTvoZHc4AjXxWo72FhCC5po/1IkVbUj2m5khZom2Ias3DJFs3ldtyP61Lcbiu0C
 hl0+dJ0kEvToxfNojfUSd5VWkk1D8TnqxG6Ck0KzEv/0bhd9qdgOQJDASygIZZJK5j
 hkwsvuSjMaeUnAZ2M8Wwte20vqushYu8R6UtrqDpcT/pLbpps3DD26187iwMCYp2xM
 NqReSRoPng1JY223qLCugqqmdGD3WIlDAY4J0lZtz+o610Z4dg7zfPW4PsFrzUquMf
 zCD51KcDKuJYw==
Message-ID: <86627f3f-cdda-4165-8ca2-0c8dd4e321a9@kernel.org>
Date: Fri, 13 Nov 2026 17:31:21 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>
References: <20261004061007.7433-1-jsjlee1020@gmail.com>
 <f3f5fe2c-f0f5-4c23-a2f7-6cb5e09ced5a@kernel.org>
 <CAPHXVrzaWHYccYe+PWLeAf_N3md8ens0UsW7aH-047KGhM4BUg@mail.gmail.com>
 <102da404-ab62-4ba6-b46a-1846ca64c72b@kernel.org>
 <CAPHXVry2O-AYxTvGdzu+m6b3Q=ho=xL0kpWWqCn0vjj-gOe0ZQ@mail.gmail.com>
 <0e156b8a-2876-4bbe-b16c-55c70b3201b3@kernel.org>
 <CAPHXVrxHvXChxiBxCcHWLaFwvatnDVhSu7wdvPWiBDYaUSOQJg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPHXVrxHvXChxiBxCcHWLaFwvatnDVhSu7wdvPWiBDYaUSOQJg@mail.gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRnd4-000000007cE-1sEt
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip further SIT updates for already
 invalidated blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, yi.sun@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Seongjae,

On 11/12/26 18:36, Seongjae Jeong wrote:
>> I don't see how commit a66cdd985532 ("f2fs: introduce discard_map for f2fs_trim_fs")
>> introduce the bug? from the timeline, at that point there is no error handling in
>> update_sit_entries() if sit bitmap is inconsistent, right?
>>
> 
> Hi Chao,
> 
> Commit a66cdd985532 added the following two lines:
> 
>     if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map))
>         f2fs_bug_on(sbi, 1);

Previously, we will trigger f2fs_bug_on() and there is no further error handling
at that point, so that we will update SIT_I(sbi)->written_valid_blocks as well
incorrectly, so I don't think this is a bug of a66cdd985532.

Thanks,

> + if (f2fs_test_and_clear_bit(offset, se->discard_map))
> +     sbi->discard_blks++;
> 
> Even if the cur_valid_map bit was already clear, the added code
> could still clear the discard bit and increment discard_blks if the
> discard bit was set.
> 
> Since my patch skips that update for an already invalidated block,
> I thought a66cdd985532 was an appropriate Fixes tag for the discard
> bitmap part of the change.
> 
> Thanks,
> Seongjae



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
