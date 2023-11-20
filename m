Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B23C5ACB3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Nov 2023 03:20:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r4upa-0006kR-U9;
	Mon, 20 Nov 2023 03:20:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1r4upa-0006kL-3R
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Nov 2023 03:20:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mS+QScR4CYHjpZgCrte4Dp+KllABBfJ6CY+nMOOQ6Vw=; b=YeTm0QvL5fL34WebZnzffFOy89
 iMk4M8KTywgVCEVNjDmtSU1AREAwpqoTR/a0G+vG4WXplkaFz1gIRAyCePBiLtAvjEYxdS3RPRKAJ
 8vVG8Ctv0LyYJ55Ts53D9uiMMtuQXWjubvoJfuoSzoFXYm8lS3hfeMLB+Dt7kozRZkPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mS+QScR4CYHjpZgCrte4Dp+KllABBfJ6CY+nMOOQ6Vw=; b=PJCI6Qrj/hKoGPHbQdDy7eobxO
 l7qseVQjBQji+4HHYWW8hgdylDXTnlZjrfHjpfDH49eZpu0Ys4tej25A/NK2qufwUq9wc9pSuQPeU
 c+lFoLQgsFgnneswi24uDLLyEbGnimaFD78BOx8xtEHrOyzth9APNvmwXdLdno6U62zM=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r4upV-00AgC2-GB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Nov 2023 03:20:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8844FCE0E15
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 Nov 2023 03:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AAFC433C7;
 Mon, 20 Nov 2023 03:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700450399;
 bh=mS+QScR4CYHjpZgCrte4Dp+KllABBfJ6CY+nMOOQ6Vw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OwzuYUWnWzmg0N+phG42U8A1maJOLvivlbjsq2EhTqSbt74HLy3NdQmMqozKwZbeM
 VO6+ZA/xNepf04+rzNo4RaWWxjROm0GOHPsj7u8lFhUujRosj85f/QS6rmuKg9N+78
 V9u2mbQlfrxUNkmtA+XM2sHi+DMqbGHiqHU8rSHrEf3GIjAjipWSFRsjh6jP6EKD6+
 MSJwMHrBNxROHwwO8p2QMewM+o03Q6sjznwxs8LDF60uf0qAHIH+U171cmYFfy/MNL
 xQsCQJ+9sJhNQ/ifBXIfdRJymYvpIZgXstKXu2Cr+0L8QjZ39phM5EPf8rx4Qb8VsP
 qB+0iBCBqp6dA==
Message-ID: <5939cb04-071a-9530-32d4-44fe16d23565@kernel.org>
Date: Mon, 20 Nov 2023 11:19:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231114212414.3498074-1-jaegeuk@kernel.org>
 <4a0e1c6f-12c4-f3dd-bb26-4bf0aee6be4b@kernel.org>
 <ZVQwz5ubx9LojzEf@google.com>
 <236866a2-41b0-2ad0-db77-4c377367c80e@kernel.org>
 <ZVel0bHLlg4IizJ_@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZVel0bHLlg4IizJ_@google.com>
X-Headers-End: 1r4upV-00AgC2-GB
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip adding a discard command if exists
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/11/18 1:41, Jaegeuk Kim wrote:
> Not sure other cases yet.. let's do one by one, since I hit this in real.

Sure.

>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thansk,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
