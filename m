Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560C3CDD566
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:37:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sr66N-0005H6-Ui;
	Thu, 19 Sep 2024 01:36:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sr66N-0005H0-0w
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Sep 2024 01:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=th9nLSU29msmOyzpiVnxvSjIxGvRDXTkxesj9wai+sQ=; b=BgS6Z+rgyUGyxJ3ociojWF0h8w
 SQGHB8b022j2FnmxidHl6/72Q3KoaS6IPHM6m/V9tBpdnXJAJIGwlqChskV/w7GwSXka/t4lZnZ8D
 /gbYQA3+f8pt50BUG3ScoMrixmAFjDsIgDXj8RCVUDGe2MjcWh+js54AlnwKwZlLq3WM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=th9nLSU29msmOyzpiVnxvSjIxGvRDXTkxesj9wai+sQ=; b=kj1NUvXkS9+WvyhylCq7tL5nEM
 QBcgNpdckxMeoRQS6cXzO1e5nSlb4AlPEj6xghOEzoYy/7xQDcswvOp5OIqGST1F3dYlx4MZ3Ouxs
 GAdYz2k5IftCOuM01qKzp1l5mUSlt9IckoCTVfpooJAqM5TjtGaQojxiyvRitK+cuJhI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sr66M-0008MY-C6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Sep 2024 01:36:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 49AB85C5B95;
 Thu, 19 Sep 2024 01:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AE5C4CED0;
 Thu, 19 Sep 2024 01:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726709812;
 bh=I0UJ2oNGmsWctM1cfjRK+ScHd9ScxRdCDClQVSqtoMg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=LPO+xZIonbTu7jEDd98AjIlc0Aei3jl5jX96TQv335DbzvZY8FJ2pcXasymj2/Hpm
 LUlTIrFEbeP013Q7e1ikwSe3Vah6D6tboUMdjhhhEtgGjCG0K75jnGY0xx3PGaLvzU
 GHy+SENTd+AS1GYOktdNjdLhYexWpveWtdYa05GYmJWahUUbxh+Qr0/oXwbfj7RUBN
 JWU+taBcqkFQPybcZTdXdk4qLk9/jeHaTooXhDsSch6w57pECxkVp+Z8JsMZPCUvhR
 iBZYR4/mdOqIYOAegewDhhYcVt2vnbZ15UI7uVGTLTjqn7waJmUcBXnMKwI2VTvdLn
 Kuid3GERz9iYA==
Message-ID: <e97b0a37-bcfd-4d85-9d46-af3e82f6fffa@kernel.org>
Date: Thu, 19 Sep 2024 09:36:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liuderong@oppo.com, jaegeuk@kernel.org
References: <1726653980-590956-1-git-send-email-liuderong@oppo.com>
 <1726653980-590956-3-git-send-email-liuderong@oppo.com>
Content-Language: en-US
In-Reply-To: <1726653980-590956-3-git-send-email-liuderong@oppo.com>
X-Headers-End: 1sr66M-0008MY-C6
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: introduce f2fs_get_section_mtime
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/18 18:06, liuderong@oppo.com wrote:
> From: liuderong <liuderong@oppo.com>
> 
> When segs_per_sec is larger than 1, section may contain invalid segments,
> mtime should be the average value of each valid blocks,
> so introduce f2fs_get_section_mtime to
> record the average mtime of all valid blocks in a section.
> 
> Signed-off-by: liuderong <liuderong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
