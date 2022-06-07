Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634C5C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jun 2022 18:09:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nydeF-0005ul-26; Tue, 07 Jun 2022 18:09:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <willy@infradead.org>)
 id 1nydeC-0005uZ-3r; Tue, 07 Jun 2022 18:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AfL2iuaKMIW3GEEXa7GrCIERYid9+IWuPeOvvtY3ld4=; b=bPfp6A/E/YwkkjY9sclALfc5A0
 3+J9QqRx1YBrAdtru1ywHUxHCKiUs8h9cBhnnRAniQQojJD5EzlT1hcqtC+f9+K8kzjzCR52RZ1vq
 P1UjCnIniRX3kGAYarPSCf9ditYgAbYYe0kAh1X+BMNHZkJNRjf1gEqkNHj2lO2PalHg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AfL2iuaKMIW3GEEXa7GrCIERYid9+IWuPeOvvtY3ld4=; b=k/cGMveeqj2N/5eLRC+pmONn/N
 R8TK/dMRNBB3zJ2f8wRn+/kOhVzmMuZVHNTne2TSTkqwN2Nd3csizY1tNFGmO793F+xF100LTjJmn
 rjMhWxhLFVPR3qxI7CoFbRGpOgZ+KrR40ZREAai0pZFW7wmscsSppGBMxWb6ABPhDO4U=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nydeC-008X4r-71; Tue, 07 Jun 2022 18:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AfL2iuaKMIW3GEEXa7GrCIERYid9+IWuPeOvvtY3ld4=; b=fRSk5WhSy4yx86ABGN8DAKmWjC
 5IdJfhP/2tfrBb3qOP67dWCLnwarcUWbjvi3CSZox73Cc2Y1PIwGlfqeGnF3Uxyt0mbA5Mg3BbAic
 u8C1w1Bg+HnPIgHl9bpnhpAGnvXoNlM/riGdn7iNiA4dEw1cH8c3GLB6l+j+CAh8jR4QCRLgjeJYJ
 KjvzVwo8asMupiPKaBH9YNKuxq1ZqBG33mo7YsQtWCkEXiw/2CPMhM29QfN4S2WqjmyhTpN+ujECh
 HLTSFWPPBpUYWjBGjh365kLciirfPTZ2IaAsMeDnES6CMIrk6IVPXnxuuFSWcG0n8eXm6dw3XUxLO
 bUTOI4Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyadh-00Bioa-Tk; Tue, 07 Jun 2022 14:57:01 +0000
Date: Tue, 7 Jun 2022 15:57:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <lkp@intel.com>
Message-ID: <Yp9nPSwPEWoX7Ml+@casper.infradead.org>
References: <20220606204050.2625949-5-willy@infradead.org>
 <202206071139.aWSx4GHH-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202206071139.aWSx4GHH-lkp@intel.com>
X-Headers-End: 1nydeC-008X4r-71
Subject: Re: [f2fs-dev] [PATCH 04/20] mm/migrate: Convert
 buffer_migrate_page() to buffer_migrate_folio()
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
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 kbuild-all@lists.01.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 07, 2022 at 11:37:45AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> mm/migrate.c:775: warning: expecting prototype for buffer_migrate_folio_noref(). Prototype was for buffer_migrate_folio_norefs() instead

No good deed (turning documentation into kerneldoc) goes unpunished ...
thanks, fixed.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
