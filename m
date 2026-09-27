Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9FFC98338
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 27 Sep 2026 22:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PoKJRLcivyjAtbEEpXj5G1h3qRIZEQPju5TEqWkhyls=; b=dgj8VXJiBu4YOl51QJGG5MbtSW
	4rm+AJVbkGVS4VAj5330Wn3vj/7tJif47NdF0/BeHuZlayjHTrxzZNcgdlWge1Chx7HPf2Npz+COC
	ry39vsb/x7kGUl7ykj78Mjlh2Vz94Fhwt0POBd4r+V0NvFA5Wv8WLEY6kGryU4b3pLj0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xAxg6-0007gE-SH;
	Sun, 27 Sep 2026 22:49:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xAxg5-0007g3-QW
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 22:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=py3FWWgh37ZtpQZJsiyyfNmzFNQ/4HLrvvHaB+jkBw4=; b=HvW5haFfflcnDywQHTC8VJqS1R
 RJVqA/wJdm4XnjicqN43Mu09vGY7WQgcea8f4uw9w52xTcAnjoaKXWWpVXshYLkNwSPSJUZ3JrVzH
 nKq8ezTVKuPMDYjHvwcXZa4DFBE43dzh5XoIDiT5NXm3auQ2fPPJATAMXz7OIN6WE0XI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=py3FWWgh37ZtpQZJsiyyfNmzFNQ/4HLrvvHaB+jkBw4=; b=V2Kgf/SWVCrURgqW4lJSwGevv5
 CWk3Xg4T3HLVeEtc2P5v2S/PGm6JKKkBtRdNkvewXE1LChVraNsq3Nq9IQ13KF3fld166SXZ1I/7D
 stOug4LcrTpwJKK1+VUNLFDYLTFF+4vTS9yz+KUlJasx/unZjkqfKj4kXDHofUx9ztWc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xAxg5-0003kF-CS for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 22:49:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC56F60052
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 22:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A5D1F000FF;
 Sun, 27 Sep 2026 22:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790549335;
 bh=py3FWWgh37ZtpQZJsiyyfNmzFNQ/4HLrvvHaB+jkBw4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=B0oarYu8vL5xt/zkiLN47f7mk3rRJujql71dB1G/3R/ppmZPZpEtphbaK4Xwsv3ax
 b2OFT9+OePf4DiBRD8kkO1MNJNkMz1iTYOfuqhQAxJzC9hlwkEa/N5dXHpzvOziwFe
 73bt0NsuZRGw3m4FLLHsx9HskLGvWifui4XAISS7eeUcQAxbFalgmrxiHtWIzT5Otd
 fPxJA2P9woXkroDvXmqdJvSAh+adg1p9aZGVTadeMIfbvsKD1ufCiHmpTmvpQncgDw
 lzE2v7owD+5i6UIfco/2l2kU9Ws15MracNV1w7gkmmAD/aNTdn80XiSKVuiCHs24mF
 RciQwcqGYjLkg==
Message-ID: <da2b1dd1-bb24-4d05-8705-3b5bf7443a5a@kernel.org>
Date: Mon, 28 Sep 2026 06:48:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Darrick J. Wong" <djwong@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
 <905a961a3bb2ec345285f056053e3016ad3bef6e.1784949155.git.asj@kernel.org>
 <apc5PMJFYtrUyG8U@zlang-mailbox>
 <ea5b61d4-0cba-4afc-b5e0-8720d4717872@kernel.org>
 <20260927150618.GZ6253@frogsfrogsfrogs>
Content-Language: en-US
In-Reply-To: <20260927150618.GZ6253@frogsfrogsfrogs>
X-Headers-End: 1xAxg5-0003kF-CS
Subject: Re: [f2fs-dev] [PATCH v8 13/13] fstests: test UUID consistency for
 clones with metadata_uuid
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
From: Anand Suveer Jain via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Suveer Jain <asj@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


>> _require_metdata_uuid()
>> {
>>         case $FSTYP in
>>         xfs)
>>                 _require_command "$XFS_ADMIN_PROG" "xfs_admin"
> 
> The presence of xfs_admin doesn't guarantee metauuid support on xfs;
> the script predates the creation of that feature flag + cli args.
> 
> --D
Do we need to check and guarantee metadata_uuid support on XFS?

Taking hints from xfs/077, which lacks a check for metadata_uuid
support, leading to _notrun()).


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
