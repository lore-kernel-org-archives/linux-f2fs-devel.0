Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (unknown [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92404C6FD1C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Mar 2023 14:47:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfMDm-0001PB-Ip;
	Thu, 23 Mar 2023 14:47:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1pfMDl-0001Os-Nh
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 14:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2PSG6kT36CkBgT8ei5K71qzuiLAw9IbqghpRjidCjVg=; b=UDQStOqXYO9Nkqnc7fshi22nHj
 p0b7930puf/adIIIRsrIpOrdXYAagWTwZCfRr5jrwLV6j+MjVhF4CWzj54kVW1LkT2CR5UtDgQHNW
 euQzo/inlPzEEg+Sm/ojlbshDqigeIHfvdc0CF7ItxAsND89FJgm4BaEXJqPGRWQSFgI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2PSG6kT36CkBgT8ei5K71qzuiLAw9IbqghpRjidCjVg=; b=Ng/2EY5S+5WtFSjdwSvQyNtcfb
 lCc5GvXfAYwzPaNJI4LDQbydvW+8c6bm6sjjzpH9LdO6QsIQV4KVzmBT0Kc95nVVA2Q1xurTsZANZ
 alAO4/BgkX814AYzlcMG6pvQa1E5g052x84KILKo9vV3x3bXujFbxMZS4fo0mBFhTy5U=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfMDl-000J6U-JS for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 14:47:18 +0000
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net
 [173.48.120.46]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NEaMVT012103
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Mar 2023 10:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1679582184; bh=2PSG6kT36CkBgT8ei5K71qzuiLAw9IbqghpRjidCjVg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YNMEWSEK/bpf4wrXU9PCz+Cs9x578xeEeRj8/aSRvYm6/q1R41hDWeh9K35tdPW7t
 Xm6c7HPXVUm51FTDYw8Yjf486KHMGFN46uJfca8hUvxcxfyBiDB+47HL6adcWMEQPc
 IeUY9ouonFKpoSTBEqIoJ3qMNs7Nh2HFKvrb5h7LO8lTaPTLDyzW34DPiVRcX8laAp
 YU7kgko7ggR67GmhDalP3S874Yb5MnrIYsaEvocj+YKp+Y3Lo5GEffptlLiINroZ08
 nogJ9LbA9TGGgdleLsIecmmt5CaS6nPd4R8mlkgztJf8SCWgrajm3xs8onVrC5f3N6
 VEWYIXSsr69+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 0EDD815C4279; Thu, 23 Mar 2023 10:36:22 -0400 (EDT)
Date: Thu, 23 Mar 2023 10:36:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20230323143622.GE136146@mit.edu>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-4-krisman@collabora.com>
X-Headers-End: 1pfMDl-000J6U-JS
Subject: Re: [f2fs-dev] [PATCH 3/7] libfs: Validate negative dentries in
 case-insensitive directories
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
Cc: kernel@collabora.com, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 22, 2022 at 03:45:59PM -0400, Gabriel Krisman Bertazi wrote:
> Introduce a dentry revalidation helper to be used by case-insensitive
> filesystems to check if it is safe to reuse a negative dentry.
> 
> A negative dentry is safe to be reused on a case-insensitive lookup if
> it was created during a case-insensitive lookup and this is not a lookup
> that will instantiate a dentry. If this is a creation lookup, we also
> need to make sure the name matches sensitively the name under lookup in
> order to assure the name preserving semantics.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
