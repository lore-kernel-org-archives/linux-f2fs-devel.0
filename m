Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E0DC44512
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Jul 2026 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:Date:To:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hEv+8l/LjYnUf0InM5NnUWk9v8aLZR0ZTL80DK3DK6M=; b=hvvemP6Ju2sl9oHh5/CMrAitPm
	bSmMS1/pULpUh06EO8iq7s3cCxSLIjFrbZfHl20Urp5uyda5T/nZidoZI06YP6aYf1eyPutds6rKc
	u1AX/LaW5jDsivMAte1HAXgcUkJfXPvfk0hv0fmDCFqw3nWOm9vGkQn1M85YoYoYcur8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlNSu-00060L-6T;
	Sun, 19 Jul 2026 09:05:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3497809730@qq.com>) id 1wlNSs-000603-C3
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 09:05:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rAtwND2rAUAbBJ7731DfZ0ipjuKIaWp103pKRv05ylo=; b=Ufg4KlLXVjUd+zfIsuC/++eO2j
 xvVvUUCIXvU00jWCYq/C7RonW2O1EWKHx4LxFlIKZEy40aiMlObkvYP3LmLpveWEaXMIyatca4sgI
 4qFAYIoQoStB75aDu4OXB2VE0JI1WPle0SYXqapNZVf8E3VgkY1074Y3MJxIG7h0KohM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
 Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rAtwND2rAUAbBJ7731DfZ0ipjuKIaWp103pKRv05ylo=; b=koT5XyuMHJxOTdoVnJ5BEppoSr
 p+r2MnjJAqPr5kSJCBJXub8M+lZaSEXFiaKrkxI2ESwYEjlkdItOQFyEwtFXiJjPXw8j1+RzBg82d
 jXahrcM1OQCEUT5R/fXK21VQGKRs/SsfWDrqW7Te9aGtIVkTZaton3LzyXdKBJfvQsRI=;
Received: from out203-205-221-155.mail.qq.com ([203.205.221.155])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlNSs-0004m7-Fp for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 09:05:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784451926; bh=rAtwND2rAUAbBJ7731DfZ0ipjuKIaWp103pKRv05ylo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=na/9If7HAkjBa22kbpFVQO4FDWJXRTiPxhqexJKUgJuycthVzc/a6SkF2xr+Fn1P2
 s6Nwp+FlDDIotMS5xFT6e0M1NV7YlXYuhKqrBzONmPvLhT5WkXfYuKAMLSxicpzUms
 v+2QFdnDUMOH4ORND7KYQyAeO/jTOWRovVQqAl9o=
Received: from ikun ([223.65.85.165])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 1561CCCB; Sun, 19 Jul 2026 17:05:22 +0800
X-QQ-mid: xmsmtpt1784451922t3v0oh9sy
Message-ID: <tencent_2D9E7B21C16E6E10F2315454333C5E8A4D08@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GSlixnE/LQRUNsi5xsJxZNrDiEhXnBdFsH4JHIzhhaSyhlNfDip
 5jbsrUm2SI+iPB9ObqMDcY8EB5uONKFF4MKI98/KWWfxNKS7oiw9J3YCo/8TVbw6G5STBMajXGpo
 zicXnbCCZz3vQWfh4VCLHZXDlNbpQsBpYpFUZ4JuR8pczHQMXCt7A3IT2FmQ5dilmTph6BiqbGqT
 OMl1zmXbm0Udv/kxfpYH5qkx3ar/c5byRuHreKg0buaOyVO7hoVxGzo4K/stnijZiruLPMAtfB1Y
 L4trnwoSkoTRvOCLaxlpPQ+UxZoLSbPWbsi/iAem0QdvNqn2wm6mS3ZDAOAnC9/tTDUbZVSguCKM
 iBAu7iQO8S5K9HtbGhu3su3MaCeQG3MSJcrrKDOL2c0h8AtQAu/9GB6D/luP6PMEf3MQK8B6FG9m
 IYMlTVuEqX9jW06qV/YnWzjIr9mFTgZuu2SRSHfbG+BrnsV5PMVKLvoxAVD8veOVKwy/VnFrguFm
 c42hXD9SATid+p9lEFGXUqm3er7HzTxtsmqUgzkkB8tv3yd/Y/jPX8HbXgiXZ5Gne/dBUQebvy4D
 lxGB3GhNJntdtsy3IjzOr5QY5iMRV34qvv62xFyPAFA+DlTSgvy0RQbW+wCI7pbAg+N2v2412+jd
 O/vxnCMjq2wHYHyzPr1kLBh0LkSn45jnjZ2z4juR7goIHz/iJZeVpbxFgWL4lOjy/52xTuBaO+Ct
 Er3HQM9VN/dPkhQADLoh67E9mrpF9PmD3/FPcmrcGVhx6c7Kd0NSBmkbjYz7/uaMIH9QZCfSocLW
 etkB7IlgcjRnfJ7tS4dAy1JUP3tZiU92SNBjJVTqtebvC94tfZuJTrvjP/ntyIfm2y5hh7wYZyP1
 I9vHGxa2x9gEZe2nUkVLb4iS/hgcAHwC1bJe3HRiJI/IVri9qBB366UZw6C8/EPQt8/wtrLqsCB/
 XgvyTIzIpaiFQhjUC++Piib27VnhnXqVN/mKwaGjMrJd6PjEw3HufLsjK1LIhL74+VfFENbPLSH3
 boSrtl7Uh2gPHt4j48agUVTTMRfMwqf51JBKtSMHIiyAF94jiS
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
To: chao@kernel.org
Date: Sun, 19 Jul 2026 17:05:19 +0800
X-OQ-MSGID: <20260719090519.1473-1-3497809730@qq.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <c9081653-4295-4605-b543-ee84000b1ba4@kernel.org>
References: <tencent_FA4515CFD8902EB74708A91807AA001E3507@qq.com>
 <c9081653-4295-4605-b543-ee84000b1ba4@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wlNSs-0004m7-Fp
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix ifolio leak in
 f2fs_move_inline_dirents
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
From: Guanghui Yang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Guanghui Yang <3497809730@qq.com>
Cc: jaegeuk@kernel.org, Guanghui Yang <3497809730@qq.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks for taking a look.

f2fs_reserve_block() drops the dnode only when the inode folio was not
provided by the caller:

        bool need_put = dn->inode_folio ? false : true;
        ...
        if (err || need_put)
                f2fs_put_dnode(dn);

In this path, f2fs_move_inline_dirents() passes ifolio through
set_new_dnode(), so need_put is false and f2fs_reserve_block() keeps the
caller-provided folio.

The caller of do_convert_inline_dir() also drops ifolio only on success:

        err = do_convert_inline_dir(dir, ifolio, inline_dentry);
        if (!err)
                f2fs_folio_put(ifolio, true);

Therefore, when f2fs_reserve_block() fails, the ifolio reference still
appears to need cleanup in f2fs_move_inline_dirents(). I kept the cleanup
local to avoid changing f2fs_reserve_block() semantics for other callers.

Thanks,
Guanghui



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
