Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F038D60D09
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 19 Nov 2024 02:25:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tDDvk-0005BG-5t;
	Tue, 19 Nov 2024 02:25:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tDDvj-0005BA-Gm
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 Nov 2024 02:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7EGJ8cyBENrORFwEitLFZBHpKkWachRM+lxhmCyIU2I=; b=SqSPle+Hje1zMLJr+G+1CfJ4x6
 fuu+5xBPEHAHoqIe0CCmL7qi+/nX/zjjEiUeueMLWPHZQdRJ2WObvLqaq7opowBOQ4vpnLBPZD1/v
 ZO6tbxFEIgdCQJxxHmstNCz0SDYOqdpSoBXnv3wmUzQlMwly9QibHCj/Jvtqa3N28GK0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7EGJ8cyBENrORFwEitLFZBHpKkWachRM+lxhmCyIU2I=; b=SOZfwgZEfs2kyYQfXUsE+GvWTR
 lMXglNyal5UG2AZVyg2g50EoeWavG+Ll6+ZBsiF0vuyhmpUbfrVHZ/5htvjRHBQBP0Ni291I/qAqY
 OPwg1HjUniy3sCSBjJ/2c/MkNmQnnWwZzA0BXgaDd48/qXhsSh9GlcH7TpmeN7dgu/so=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tDDvi-00013l-C3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 Nov 2024 02:25:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 006BF5C5C60;
 Tue, 19 Nov 2024 02:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61061C4CECC;
 Tue, 19 Nov 2024 02:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731983120;
 bh=47dpyttEFDhx+veDJNsZewL8yCGD1eo7OSN4BfBOvoU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=BdWI7GlNPZBMyb++DxqvUhl3vOlymrTcATZfgYXlV1muOoWixVq5bbWw6445paa3E
 /Xj21pd/bqlFGhvn9ADcWc+sRUU9vtHPIPdmkd+S53j4jfFR7bFvqdg4N1T8113YRa
 NMqFcxO5FXsLoYIGuUwkKxO/G0dVPKjE0PRLD0EVr9bKcC6dpiLHaIils4MDCHOjqu
 XDZIDlMW8NJA4ld+0teDchuZWeo7zDEEOdeaTL9T+vBCrYu62hmvTlipTMQbD/0Gjf
 ru/6jAxmUsvdGRuxqbgV1ia5IoXy+LC80qKTnJXa9F67Jfk5Z11wLjtF+PwDa2X7wP
 kiFYnel7XaZ9Q==
Message-ID: <405f3117-efe3-4d5d-889b-8fdfa87d30ad@kernel.org>
Date: Tue, 19 Nov 2024 10:25:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20241118184535.1047327-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20241118184535.1047327-1-daeho43@gmail.com>
X-Headers-End: 1tDDvi-00013l-C3
Subject: Re: [f2fs-dev] [PATCH] f2fs: adjust unusable cap before
 checkpoint=disable mode
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

On 2024/11/19 2:45, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The unusable cap value must be adjusted before checking whether
> checkpoint=disable is feasible.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
