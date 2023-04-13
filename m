Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFF7C77B6E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Apr 2023 13:51:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pmxMg-0002XO-9y;
	Thu, 13 Apr 2023 13:51:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pmxMf-0002XD-EX
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 13:51:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zq6q9HznvpaBnhlvUQJtsS1rPr7IAb2oVkoaBtyb77c=; b=Ly4GmhuhP1PHNzJhg5KuopXjqM
 a8BgwB1LGX3tnC7+6fRZVcU8rHMTqeuVIHU33NNT9bfu/c399znx7k15nHPsZnYfbYNpFxgkEZggT
 oaeSwf8Xdq4Gqg3yGCDCYO9TakIZh7Bq7eSr5ZyFzDW9hC6nwpBsm9JEQlsBwlvfRGts=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Zq6q9HznvpaBnhlvUQJtsS1rPr7IAb2oVkoaBtyb77c=; b=RFQGAYveZuhKiBuSY6HzQkc+js
 NRngeFOCF0vAbU2xLQBiKiCkkxVuKOjVPITjmEgBGv9vkMDaFRa8MBIYzw9WKUpnRNdpP1lvl0E2A
 AUwCCeLuKeaYwZZLUOfByyiG3Bmc6Z4C22kHVgGgLSLtXcHTw/s/+h4MnRgajzx326ew=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pmxMd-006aF2-UL for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 13:51:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1FAD663ECC;
 Thu, 13 Apr 2023 13:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE7DC433D2;
 Thu, 13 Apr 2023 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681393903;
 bh=s/dmCaH25uHi9qR1VOOh32+D5s22j7AfxC7emCEAXUk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EmxbZaXmOKsfFhrWOWe9XZto2cFMKYdqZfWd2awovET6dWD3kOE742H29DzV1bg0l
 fBQpsb6Ctw3O3CyE9JmOkSJYnVadG6S/veP6zHbD4K4IF+8HW0uGphWDw8EssTychz
 EAWtReusOZABW2XvWOyjiV7j1rDviVH+BFgmmqKNYH7xzLl4HYNQg8lgKvfdl4pQRu
 Db6mmx4R1jxNIRtpy8ef+aRN7Iy4N8+Xxv9d/06rAzCp2rCIEqrdm4XM/1vzUM9XQW
 vQ5D20MJw6FKqsQZF6YhDnNH2UtARDE21u8H1FPmNVwuB6Lf/9Vp8cx3rbeWMgSt56
 IRPtWcq3N59MQ==
Message-ID: <e66f438c-b1b3-ab9e-319d-939fa665746f@kernel.org>
Date: Thu, 13 Apr 2023 21:51:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20230406221104.992322-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230406221104.992322-1-daeho43@gmail.com>
X-Headers-End: 1pmxMd-006aF2-UL
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix passing relative address when
 discard zones
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/7 6:11, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We should not pass relative address in a zone to
> __f2fs_issue_discard_zone().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
