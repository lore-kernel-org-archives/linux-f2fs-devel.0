Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79055C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:References:Date:Message-ID:In-Reply-To:To:From:Mime-Version:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FOgwHPy4Erqm4wSvGQrowFRK39PrByHMeMLKALZUV0k=; b=QUWAnZUQzmwrK9rIwR0/d2wHMM
	bEQeUsrwA3xx2rjz5Tvb1bErAOhPNCYVb08m6R7MlyZUUrlck5UnhA/eQeDcMhhcwgVlPFOQIVtih
	FzORGmAxag+FvFUE84dZIOn6BKl+hNVX9AwxgY8eU6Jcd/8fMkfWy4f93ydmfA/cyXH0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weVcx-0007ko-9w;
	Tue, 30 Jun 2026 10:23:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daejun7.park@samsung.com>) id 1weVcv-0007k1-O0
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 10:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:In-Reply-To:To:From:Sender:Reply-To:Subject:Mime-Version:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7RU8rhmK3i6p2xEptEBBeiSIK8gzA31epqd1GUnge/s=; b=HeIJGdlrCAaFAkCqZcrwuKaDEn
 TsZepeD0XymkyfLAZiJruJ3NNC/0vh1abEGafysPFyupf7WF07qoL1dLXaGPMOyZ3e1OC/v5XyjIp
 7Ut2XuPplk5rATltDqRAOr74LdbO8XVxaBH8jCFrgezi/fvWJO9sR+ojoiav3q4UIjL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:
 In-Reply-To:To:From:Sender:Reply-To:Subject:Mime-Version:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7RU8rhmK3i6p2xEptEBBeiSIK8gzA31epqd1GUnge/s=; b=IlPgLyAtSO2ln9ZxqsFJZUKq8S
 aPWIP0yTbG1GltDxIfDOgCsl3lF7qjfmoBCKpXrh3VlCu4+O3zVzYnPXijngalxKfREkwxQt6fpoy
 fjWGEhJdBVfcx/pZJrWYmzkK+HFdft1FKTlZpclwIDKSE/MFjFTFaLlZvX+oBZMl43LI=;
Received: from mailout4.samsung.com ([203.254.224.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weVct-0006L5-Fh for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 10:23:37 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260630102324epoutp046b57c9d8c1bc57ffcfcae236d382bd6f~91MznV_WE0432404324epoutp04d
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 10:23:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260630102324epoutp046b57c9d8c1bc57ffcfcae236d382bd6f~91MznV_WE0432404324epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782815004;
 bh=7RU8rhmK3i6p2xEptEBBeiSIK8gzA31epqd1GUnge/s=;
 h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
 b=VkMl/EYFfPgSugd4D01x0dxtOBfV1wN6eQDwihXsYRu4NUbSylY18sBasfDT5jiJ9
 6JHlYtqpssw3ASDBhjagDwlWmhif3HkQITZp0/Gaue9asXCpFsBOd8ZANfZ6ntBovK
 FVO5NBDxgoAu8WBFFloerBw8F9LphD70LXa1NYUo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
 20260630102323epcas2p2cad6ac5bfafc673c62825c237f861281~91MzKPjOY1690016900epcas2p2S;
 Tue, 30 Jun 2026 10:23:23 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.203]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4gqK3v2QXfz3hhT8; Tue, 30 Jun
 2026 10:23:23 +0000 (GMT)
Mime-Version: 1.0
From: Daejun Park <daejun7.park@samsung.com>
To: Daejun Park <daejun7.park@samsung.com>, Chao Yu <chao@kernel.org>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20260630042503epcms2p7b66961d1140646e3071ac93f10df22cd@epcms2p7>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260630102322epcms2p381c7f53816aee6f831c396b1f004c591@epcms2p3>
Date: Tue, 30 Jun 2026 19:23:22 +0900
X-CMS-MailID: 20260630102322epcms2p381c7f53816aee6f831c396b1f004c591
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260605091139epcms2p2b17a6e7962b7c9b8fb058e1c55cd4dba
References: <20260630042503epcms2p7b66961d1140646e3071ac93f10df22cd@epcms2p7>
 <e5ed9594-0137-4329-97e4-1e268c3dd91e@kernel.org>
 <20260605091229epcms2p406d0a66d4fa12ba1d77bc668ebcfe352@epcms2p4>
 <20260605091139epcms2p2b17a6e7962b7c9b8fb058e1c55cd4dba@epcms2p2>
 <20260605091310epcms2p7e1130728968307f799403ef00ee38ba6@epcms2p7>
 <CGME20260605091139epcms2p2b17a6e7962b7c9b8fb058e1c55cd4dba@epcms2p3>
X-Headers-End: 1weVct-0006L5-Fh
Subject: Re: [f2fs-dev] (3) [PATCH v2 2/2] f2fs: pack same-inode blocks by
 inode during FG_GC
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
Reply-To: daejun7.park@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/30/26 13:25, Daejun Park wrote:
> v3 will run the recompute only on the normal completion path (move it
> above stop:), so a frozen GC no longer inflates the trace; on the normal
> path the count already equals what legacy reports.

Correction: v3 will NOT move the recompute above stop:.

A gc_pack_max_blocks mid-section drain can free segments before a freeze.  With
the recompute above stop:, those would be missed on the 'goto stop' path,
under-reporting seg_freed and risking a spurious -EAGAIN there.  So v3 keeps the
recompute after the pack pass on all exit paths, as v2 does.  It still counts
already-empty segments (needed for the seg_freed == f2fs_usable_segs_in_sec()
equality); on the freezing path that only affects the total_freed tracepoint,
not the -EAGAIN decision.

Thanks,
Daejun


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
