Return-Path: <SRS0=r/0U=WQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F790C3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:18:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DD9214DA;
	Tue, 20 Aug 2019 17:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="J0UeeiOk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="HARiCJ8j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZI80aJI3";
	dkim=neutral (0-bit key) header.d=aol.com header.i=@aol.com header.b="C7U1W3ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DD9214DA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OXHwAW0MaY0LiqvNsjYTr9WiXE45XKqXmUudNP4SJXs=; b=J0UeeiOk8yPrGsz3z+91sSamt
	52jRYtKWpG1ying/J/SDL09dASW/Y1YBbJ/l/AiK9Fi+NCz4u0Cn7Ip8z8FaKKhlQ7fL6ev1CXSr4
	wyMp6Xx0u7ZcfQrOjK4BACAXTtpECYZj8eSkRfnipU8Hv5ND92A84hOOwsN6yiPqt+8z0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i07lo-0003be-Qb; Tue, 20 Aug 2019 17:18:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hsiangkao@aol.com>) id 1i07lm-0003bK-Jc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Aug 2019 17:18:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uMe6Ni541x/tMuArILRS79nFePqtfX01dZSfF3dkEYU=; b=HARiCJ8jfyd01Rew1AVibA8pK7
 VB+ujlfDUs5hSoaxz1lPdPaO0OptLgJ49ZD9cNqUh8lwu4Aw5YLOJXhEAFnyN/P897/mxO0gDk1QV
 MvqrruaUajooiGDxSy1i4g/xfXFrtBF6xY8dPsMQXZnFE6AGVuB2M5fsjS9dgxA+U9lE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uMe6Ni541x/tMuArILRS79nFePqtfX01dZSfF3dkEYU=; b=ZI80aJI3RHHEHfIFkPVQ7VUOOP
 0M0w6c+wl18K/KSvPYLjRIknImTZ1tQhfQXknMhGtHYboaUNs1L4qUR96hq6H6v5fTz0/WG2og0TV
 fD+9pkDVbPiKRFIKtg00zcIwtJPmYIbaQ9M3Qg0Dcttwyf4ApAjvzwwSgJ+qOsGGCFUY=;
Received: from sonic312-24.consmr.mail.gq1.yahoo.com ([98.137.69.205])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1i07lk-00DXJB-Vm
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Aug 2019 17:18:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566321479; bh=uMe6Ni541x/tMuArILRS79nFePqtfX01dZSfF3dkEYU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=C7U1W3ayuqyZ7hsgOjCE10fhEmunkatvjdHXgOJfzj80KFSyElzM+iwrIycQrEdu/75nRyyFS52j0Mv92Q0nFcZE3vazjwoseHah62vQwUD1PDfhZidbSdjxQ8dBs44AziPNLX7LofJhavVE/TrFeSCazhMjIh/d9+F4pi6t2pX5qRoZmjruRdERq4aF7uIEllEgJMhUg+FMqEwgToJam+BScNABjN8qAt++m01MwSoSz1nAgmPAAHHCofpRBM+RS9yZxXuoViD5Uk0E0K/nUhhOlLVbGLjHePM6w+2h63slRFr+U8PKIP2Ky8Te4JJwZWlbtxZVIwXVaiPG+PiaFA==
X-YMail-OSG: Y8Hmm7cVM1k.LYOMGpeBdzN2Uatlbr1IX9lewWRlqVGPFcvxoQSHHEAMk.NZwTL
 k4nnNO91Sbr0TSzU1Tzb9buMyZkhcNXHHmUowo8Au0IhVQwuGiIJC6I.JfhPLckFGR0pC_DtSO_c
 QcwnvTMqofVabosbxshdC3.RI6vQPgr0R.AADM_abVDl78X3Bqy0_NK8bmz92clhaTzp2aQ6N1yb
 13NNNSyauSpZDak0oTQqaJ3kRIO4rxvlPu7HXNRSikq1bRsk_ky.9duLEtliDSBDP6YmKyfmX0_P
 nQ1ajrvaXdiXkWYvCgJVVTnybZgog7tkyaA4t3610EsvOcMbvVmo5AR56TjIOH4Yy2rDQw.zzG1x
 iw3rXQqh1EwPDzDXz6O6SRRg_gE5GYVG7BdcK054DF8sFi0B6itcmNFKD89hppET7tMY_nkHZJQD
 1XWx2zzTRevbYvwShd28OxRGVZS1cNQCQehKcV68Hfh5..2ow7vwQEHICwLhKXceK0kzMK_fHkrI
 STvbwOs3mf2y_sUAncfpKcA3vtWREf5UivqwhrBA4YS2BxFXmaObGl1tXO86c_GKLuUwf0kNQCmM
 u5ILfnHAN60C7GsNV__8NSX5yqH3vYlC2i.qOsRVRO5uvsyS6OX4VVovbA5yLXHetuAfcnvBmSFT
 DvGhR6cml5yVXzmzWjZLnaGAWh_bE5A6yEAD7Dm_u5.rYlj4sqvjzpdr1mbTPsfMuiQ08vqFBkSD
 nWLvDwy62xnGebylj64Gn.M_JAcUEacqxogv8Mvf6oPBllx7kIR5TYtplg7.0KugMTc33QKGuvJb
 JaF53yehXvKJlgRzKanZOwhAB_eCX0yDXlVOTsLxsD0q4CM1PWzAKWCO6Rh6SPsClLF8KKIF3eLt
 0PRtwX6FggsM5eL4iAqnNqvIrm.eojNybSnao8WJvd7_BI0oAQxJ3u2xNY5Y8Cc1T9ZmAtRZDRQm
 oUeRocJWdRthyDzkynb10lpPnT_lSOWWfzndkfyed01Gb4r7YV9CUajWgTBm0gaLMjk5eJEQiBzl
 rqu9zn.YWrRETYxkIYQQWS9z.Ual_KwuTUwHUXOIJnH.Uc6VB2y5NoLzhBYM1fVqDWr3_7fSHzH1
 HXROqzGjsMRlP9p0Gs2FVD3Z_qIiDYQs3_jqllGN1cpuuuTEYu3SjW4lxtRgwZcWB.a8ZY5gmQqA
 TOeIDAP5DSJNEXqbCCOSQq5LMvIK.7QQD.rIF4ylq1u_iVDm.O.CZF.pxyztQft8oWYItnv13Q69
 rrCg92XTZ4eWNT4UO86Y2AvAgDaarEM.O
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Tue, 20 Aug 2019 17:17:59 +0000
Received: by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 338a11c40dd48f03e306532b9b1c5f14; 
 Tue, 20 Aug 2019 17:07:51 +0000 (UTC)
Date: Wed, 21 Aug 2019 01:07:43 +0800
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20190820170738.GA8402@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
 <20190816061804.14840-6-chandan@linux.ibm.com>
 <1652707.8YmLLlegLt@localhost.localdomain>
 <20190820051236.GE159846@architecture4>
 <20190820162510.GC10232@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190820162510.GC10232@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Headers-End: 1i07lk-00DXJB-Vm
Subject: Re: [f2fs-dev] [PATCH V4 5/8] f2fs: Use read_callbacks for
 decrypting file data
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
From: Gao Xiang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: hch@infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
 Chandan Rajendra <chandan@linux.ibm.com>, adilger.kernel@dilger.ca,
 chandanrmail@gmail.com, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Ted,

On Tue, Aug 20, 2019 at 12:25:10PM -0400, Theodore Y. Ts'o wrote:
> On Tue, Aug 20, 2019 at 01:12:36PM +0800, Gao Xiang wrote:
> > Add a word, I have some little concern about post read procession order
> > a bit as I mentioned before, because I'd like to move common EROFS
> > decompression code out in the future as well for other fses to use
> > after we think it's mature enough.
> > 
> > It seems the current code mainly addresses eliminating duplicated code,
> > therefore I have no idea about that...
> 
> Actually, we should chat.  I was actually thinking about "borrowing"
> code from erofs to provide ext4-specific compression.  I was really
> impressed with the efficiency goals in the erofs design[1] when I
> reviewed the Usenix ATC paper, and as the saying goes, the best
> artists know how to steal from the best.  :-)
> 
> [1] https://www.usenix.org/conference/atc19/presentation/gao

I also guessed it's you reviewed our work as well from some written words :)
(even though it's analymous...) and I personally think there are some
useful stuffs in our EROFS effort.

> 
> My original specific thinking was to do code reuse by copy and paste,
> simply because it was simpler, and I have limited time to work on it.
> But if you are interested in making the erofs pipeline reusable by
> other file systems, and have the time to do the necessary code
> refactoring, I'd love to work with you on that.

Yes, I have interest in making the erofs pipeline for generic fses.
Now I'm still investigating sequential read on very high speed NVME
(like SAMSUNG 970pro, one thread seq read >3GB/s), it seems it still
has some optimization space.

And then I will do that work for generic fses as well... (but the first
thing I want to do is getting erofs out of staging, as Greg said [1])

Metadata should be designed for each fs like ext4, but maybe not flexible
and compacted as EROFS, therefore it could be some extra metadata
overhead than EROFS.

[1] https://lore.kernel.org/lkml/20190618064523.GA6015@kroah.com/

> 
> It should be noted that the f2fs developers have been working on their
> own compression scheme that was going to be f2fs-specific, unlike the
> file system generic approach used with fsverity and fscrypt.
> 
> My expectation is that we will need to modify the read pipeling code
> to support compression.  That's true whether we are looking at the
> existing file system-specific code used by ext4 and f2fs or in some
> combined work such as what Chandan has proposed.

I think either form is fine with me. :) But it seems that is some minor
which tree we will work on (Maybe Chandan's work will be merged then).

The first thing I need to do is to tidy up the code, and making it more
general, and then it will be very easy for fses to integrate :)

Thanks,
Gao Xiang


> 
> Cheers,
> 
> 					- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
