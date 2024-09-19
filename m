Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC46CDD566
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:33:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sr63Q-0005C1-D7;
	Thu, 19 Sep 2024 01:33:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sr63O-0005Bs-OL
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Sep 2024 01:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OW8YVAuxqjgKZ2goFjD9PXfIkgKAnm0IbXernlCJTJA=; b=kHrl9KlD+DM2Ry01r+wrSYrc/V
 4zdgtBJ5B7FHUPXT1qIJ3i9MXVhgiPHpRy5ExBjP9NVKgtPJI5jamzGVbKaa8oNqSFDpltcHJSVtk
 BNkFHn2OIf3Ygq5pvpqONLNZPCpTFLzTb3TKJa56MKITEwdXenM44jd5Ip9z309MMSQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OW8YVAuxqjgKZ2goFjD9PXfIkgKAnm0IbXernlCJTJA=; b=C0j2CnJZAxDo1qmRJkSqfEmGu9
 r6rFYr7o/JgmHYJsaKx/BdnwB1xMR+j58TgKJRhR/St8WkkRJ7Hf4bbh4OylD1gP0pLGRsHmV5yyK
 yNINhDFAy8N721N5Ixc+0kfPm2YkjLzTeJC4a5PH7Fv2eduOZMR98zhYFpkDgPvx9p2A=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sr63N-0008FQ-NW for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Sep 2024 01:33:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8035F5C5494;
 Thu, 19 Sep 2024 01:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4611AC4CEC2;
 Thu, 19 Sep 2024 01:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726709622;
 bh=kIzzmFri/kJgjyyeug4PoRnrFCPRQ2ZgVw2wfglOml8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=f+32dAq9/k8CCkNnfzl9zXysl0mbgWIHSLV/Uwumz2GVh/V4IwlwDqLqJWAC0Rg6f
 jx1XHyYO0cHPfjlrlpXKOe6odDm68AOqMMaJvz5wOtAMHpB8v4g45F2l3cJOcVB/f+
 39maLEP40D7hu7MkGssx9oe2Fc5hWZiNZf3wKpbtQaIN9RMT87PTrZ9mydOUT60FeP
 bYiOlrF2u/ESo9Yo6GcMvJMvjzeQnmnDp4WPItzCIgDzUg7c5P0yROOzVQc+QXo0eE
 /rCmKMOPy9gJRhZI9MbrhEOhmS5FeyMO5zxq7K3SAcR+xFbyYrGu7yM8fdj292pGD0
 +I0x4I5yR/TMQ==
Message-ID: <7ab615e8-348a-451a-b5bd-d95a6964a36a@kernel.org>
Date: Thu, 19 Sep 2024 09:33:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240916192014.1611002-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20240916192014.1611002-1-daeho43@gmail.com>
X-Headers-End: 1sr63N-0008FQ-NW
Subject: Re: [f2fs-dev] [PATCH v2 1/2] mkfs.f2fs: change -c option
 description
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/17 3:20, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Current description confuses users like they can add addtional devices
> with one -c option using commas(,) at the same time.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
