Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC45C4450A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Jul 2026 09:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:Date:To:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EceKWzSeK1NzBZG6En8NGR2rE0NxFGn/cqSDVBkMKvo=; b=eT+WaTqFvU+waZyYcsetRvHvQh
	3Jud5bxcBNHbRkJ/T8N9ZSegb4rUWylPX7NpykhSFG+hcv6iBfUJv/7A4JuHT7g+WPnf7OfxmPabo
	eZSzNCxkyF3azuAFGT1C6AGc1Lp62jP4OoOb1zJU/IyABgk9Z+5jAZxJ55IA8EmnZHiA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlNQe-0005nS-MU;
	Sun, 19 Jul 2026 09:03:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3497809730@qq.com>) id 1wlNQd-0005nF-8C
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 09:03:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uxxrm9nh/M/IV7a9hZdZggytMTJzZB21YWdazqHEI2U=; b=JJWIoO1CICgiSzaIS8V82jDSRF
 slfVPWvKntBLWDpqwvR0CWwcPQ6OPUQJy/Ulwg+INsLfgXM1rP1O1eSFgAdv10WFHRgmzQbeVm7+e
 k4EH+19rlfctwDKnAMJdzZ+rd68ehISv03D2ckEsRKEbps6zhrKHiiaoY0/IpmPcoyig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
 Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Uxxrm9nh/M/IV7a9hZdZggytMTJzZB21YWdazqHEI2U=; b=bfH219HT6dVcHTpQksH3VA7lqe
 Gys0W+dMcJwVUZWDRiaoX9DYqhw5WE+7mA+nelTqDtlZ1Bbss3jFiO6e7jODMZvi0HxnicoL6jzSO
 Z1H66aKKB6/NpRBzkuYZj6IV03ZFmDFG19wnbzAiH0oxTH7l9nbQdcSbcVQs+0YmwEN0=;
Received: from xmbghk7.mail.qq.com ([43.163.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlNQd-0004i6-BL for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 09:03:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784451787; bh=Uxxrm9nh/M/IV7a9hZdZggytMTJzZB21YWdazqHEI2U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vWiB/LjDol8499iz6GiZ93zF79LgOQ0uUsYfCWW/txHZla8/h9ipik7TxtiipJkNH
 VmQrE0PDz4Cq4YPQU6o8pWH93UeqjPKX0jDDbLiyAfzQVovHV8rQJMz+mzuIIBUZIM
 o3Lh11/5ODcnp/51eic57B7bEhqGramyfl97RV40=
Received: from ikun ([223.65.85.165])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 6F89E49; Sun, 19 Jul 2026 17:01:47 +0800
X-QQ-mid: xmsmtpt1784451707tqv0c1p19
Message-ID: <tencent_168A906742D1C6333644C0CD0D2232869705@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJQjTMbM2fT+zEqLgzqk0483wh2HcEZ47t348kDpRKS/XG3KRZwT
 IvalKvykMJXdHoDHRxauR+wih998ZfdGfaswetMPdv+05FndRtcsLAoIT1eI76CktChHG76E2Dgo
 fFkvUFVYLMMMHHVqw/sW4v5RwhttqC/B5rNEEWNyN2Bbu6TwwuzQklLcbvpSpVdZZ9G26fd9jzAS
 2RqVU8foZdE8Di1xw8nnRSgNRUzlOGC1wqSfdk5Phn0dlgQFg0552n3CRsL/WCFoqDitWQc7vwut
 tvJr0xLK5KUCodYTGODVA3q0NwIooTEF+YmHwEVq31IFMscvuRCmW8uBNS0KbTyFgIjDwLtXQN80
 nvJ2ffTxWg5HxIuspvkS3dvKSOqOZ7QfORwcfcrdQ+MnQOOXyIGQXKGWPOxPugPHqRau/NkdSw1F
 qzzfD58g5C8wftvowH/0LLjI2eRgpVSsy/mwWmV39xj9mp1qW0m4N1Xc+TNIAlvzBMqGuaC+g88c
 gU0qg+s1OtIhHb3SJkvYCHEOiM3oyaRb+oy8WrilLlxx1KSziuJfMEwwGdeCfpfJKlLezdTmRe5G
 zyvar4F5/eLhlWiYST6YboLPkiMATEljTRmgT5xHdRjO+6UU6KuJpkZj6cpVn1QsMyd+Fpq50BAe
 EoAAdpPgMkq0AzMDTTElggLupVmi1EXiDkNbqdXcYe47GlCZMGZ+C3+8w3g3puoMa8Dl/Hlr34G/
 257V7MMjka8+2UdPGTBriXMO1+kLff5t7rZcQTpfaBTpEj7RuN2DpVtrASYRtRQj8Tz9aOjbY3vD
 2TyD+2xijm6C0NiDSNiBAsfO/jQ1XMOP1Rpzof7kVv3vrF/aWbCP5lBcCCdSznX0XDrNAci9q2uk
 XVpolnEB8yr9KTSZlNXVSCp4FFv2JlzK2jociYLt9spKhPJyjENOGEw3sOV7ipzc+yFKlq11vbMu
 qKyBSnb2OsuDgT4jcDEspdnNwK+N4doHniP2YOLpPMBnxMRq5PXGT3pSDKBNZ3FmG/6LXKX4Bc0O
 3xnaezcpu3aeBg3te5u8qtF6YZY0VvbU6y3ago8b/zH2+sfJwAYYHyWdqG1LBMYvVjgJyg2A==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
To: chao@kernel.org
Date: Sun, 19 Jul 2026 17:01:43 +0800
X-OQ-MSGID: <20260719090143.972-1-3497809730@qq.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <bfb4dffb-e02a-480c-bb91-29cf97b48e66@kernel.org>
References: <tencent_90E4200062E0A9E878FE14F33C2142E0DC09@qq.com>
 <bfb4dffb-e02a-480c-bb91-29cf97b48e66@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wlNQd-0004i6-BL
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix ifolio leak in
 f2fs_get_new_data_folio
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
From: Guanghui Yang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Guanghui Yang <3497809730@qq.com>
Cc: jaegeuk@kernel.org, Guanghui Yang <3497809730@qq.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Resending as plain text because the mailing list rejected the previous
HTML reply.

Thanks for checking.

I agree, make_empty_dir() returns the error to f2fs_init_inode_metadata(),
and the caller handles the inode folio there.

Please ignore this patch.

Thanks,
Guanghui



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
