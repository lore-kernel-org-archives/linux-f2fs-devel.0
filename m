Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA5AC00528
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jul 2023 18:40:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qP5u9-0006Ce-89;
	Thu, 27 Jul 2023 18:40:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1qP5u8-0006CY-6y
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 18:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F8/V8iHGHSv+JkjaulJJfd0u7+FldJFTn2B4741bG7s=; b=BYAd6xvcUMMy58pAviDpH0omRk
 2GzsIkL7VRN66Mu74g8e2TOlhlaO0jOPj87DvjCImcPKTRW+MKH5UK0uxePOHM9RIvWI/ARgVaTuX
 RLW3FYg95UhRQNUljJ2D/gNCssSCQA95uEunb6f8GywRfXeB6oL8V7qYmSiVa8hQPjFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F8/V8iHGHSv+JkjaulJJfd0u7+FldJFTn2B4741bG7s=; b=Nl4Tt6Xj3JgaVBapqPF4nC1dD0
 zmFwQYk3SZzH1izlQVTqDHT7Txt5VNWkmNbbpcH3hBgT0AYMQMr76AOw9sHwCeC2i6/F80y4k20vr
 FuBLh9bijN9Vc1hoEmoV8U+w8ZciRZsH9bdWZfS5Fgiysa8qgRDdWCK8FeX/77SqhMOU=;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qP5u7-004rbA-P1 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 18:40:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8394821A6C;
 Thu, 27 Jul 2023 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690483197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8/V8iHGHSv+JkjaulJJfd0u7+FldJFTn2B4741bG7s=;
 b=pY7xJfduW/6AevRW1gpBnw2+o/lalqgiGdpIpgb8a36fV0VPJQbFJpeKD/+iHajpAxFQoZ
 WxDrI+mh2W7AghNhOiiYqd00cY2hnkBeuUtKKh3EqFU4K2blkRL6eM/DJRuF30KmLelK8Z
 cAJ69xSHsw1KGSoZ/V3fdghqT55UXFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690483197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8/V8iHGHSv+JkjaulJJfd0u7+FldJFTn2B4741bG7s=;
 b=ZLBm2/R+T5G/C7PnCLDJwK+SOfa4pb3gmcixk2m0cqwJVAMWXz9y7botWgDEYF2IHH2wph
 Qjor1waHfaUejSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D579138E5;
 Thu, 27 Jul 2023 18:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N016Cf25wmTfCQAAMHmgww
 (envelope-from <krisman@suse.de>); Thu, 27 Jul 2023 18:39:57 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Organization: SUSE
References: <20230727172843.20542-1-krisman@suse.de>
 <20230727181339.GH30264@mit.edu>
Date: Thu, 27 Jul 2023 14:39:55 -0400
In-Reply-To: <20230727181339.GH30264@mit.edu> (Theodore Ts'o's message of
 "Thu, 27 Jul 2023 14:13:39 -0400")
Message-ID: <87cz0d2o78.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1qP5u7-004rbA-P1
Subject: Re: [f2fs-dev] [PATCH v4 0/7] Support negative dentries on
 case-insensitive ext4 and f2fs
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
Cc: brauner@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Thu, Jul 27, 2023 at 01:28:36PM -0400, Gabriel Krisman Bertazi wrote:
>> This is the v4 of the negative dentry support on case-insensitive
>> directories.  It doesn't have any functional changes from v1. It applies
>> Eric's comments to bring the flags check closet together, improve the
>> documentation and improve comments in the code.  I also relooked at the
>> locks to ensure the inode read lock is indeed enough in the lookup_slow
>> path.
>
> Al, Christian, any thoughts or preferences for how we should handle
> this patch series?  I'm willing to take it through the ext4 tree, but
> since it has vfs, ext4, and f2fs changes (and the bulk of the changes
> are in the vfs), perhaps it should go through the vfs tree?
>
> Also, Christian, I notice one of the five VFS patches in the series
> has your Reviewed-by tag, but not the others?  Is that because you
> haven't had a chance to make a final determination on those patches,
> or you have outstanding comments still to be addressed?

Hi Ted,

Thanks for helping push it forward!

I'm not sure if I missed Christian's tag in a previous iteration. I
looked through my archive and didn't find it. Unless I'm mistaken, I
don't think I have any r-b from him here yet.

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
