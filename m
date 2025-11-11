Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6298CCFA18
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Nov 2025 06:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KjzvrAKK+YBxx/uUh+Pg7BQZjKcDLVgt6ECOVsmQao8=; b=MW7N+yFQ2KTUQS+ucX0EgpB7jd
	jIXsfHtyBlBTYQkH+pD/oagfeAc50YaSQeRoZ7y7laR+iBQ68T+gR8D9j+EmLs/7ZdpZbRrgUqxtd
	QujTRna/a9HFO9Xx8s+DGU0PIhbYad0zqFRK2TlrcGoQXn+XEUeurLib0eCUrtPK/QiE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vIhWW-0007Cb-Ti;
	Tue, 11 Nov 2025 06:06:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hexiaole1994@126.com>) id 1vIhWV-0007CU-T1
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Nov 2025 06:06:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vdsHJs45ooO/M+OZIcoQXZlPX9LYJcRdvesRK5hCxHg=; b=c0DpSyZiTTzu52LdZr/fGEn1sf
 oGYmadYcPr2noufVw38RPgSqiRu6Cali6mxCoecwdz/BH0DYMO4lkuPH/PNBAna1WlI2i6B/BcG7l
 hwUgdTA9GS3JIea5sIIxYCsxbJ+gxKNyb+JipiMlgKFmYAnxnf3kdR6kf75wZpEqqlmA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vdsHJs45ooO/M+OZIcoQXZlPX9LYJcRdvesRK5hCxHg=; b=KXPUSv/qJ7UJI9/8CvdT2ssu6S
 z728Vqv78b3DoyGsQJm0fDNjhf1JVyQRFazXixJCJa2iQHUuSc8kiMXYykJT0Atg/zlYu7hcbqn58
 T7Aix4cFb+0JimoVe/VWQhNxGNQfp2SEaFsOLZF5FTxWqhzNL6+KyznWRpyPEazH3ZSg=;
Received: from m16.mail.126.com ([220.197.31.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vIhWT-0007GS-Kf for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Nov 2025 06:06:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vd
 sHJs45ooO/M+OZIcoQXZlPX9LYJcRdvesRK5hCxHg=; b=QJFoF6q0GnOALu+Gx2
 GNMuuVwsFslbpEM2aXqiIQFmQ8Cq9ouglLmNbJ2LxBJ9LWy/rG/GZaHj7PL5HnOL
 dn81ALbAUnVItW8q3PbqpmzK/3f2NAALAKbq2W9P7DuaHOBdqACnwcOW+6REXZZ6
 WrYXFvuZ86tZpU1r9Ey0tjNzg=
Received: from hpz640.. (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wCHmd5W0hJprKUPAw--.11216S2; 
 Tue, 11 Nov 2025 14:06:15 +0800 (CST)
From: Xiaole He <hexiaole1994@126.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 11 Nov 2025 14:00:49 +0800
Message-ID: <20251111060557.337514-1-hexiaole1994@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3a787685-1765-4068-a8da-d595dd257b71@gmail.com>
References: <3a787685-1765-4068-a8da-d595dd257b71@gmail.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wCHmd5W0hJprKUPAw--.11216S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzKsjDUUUU
X-Originating-IP: [202.110.209.182]
X-CM-SenderInfo: 5kh0xt5rohimizu6ij2wof0z/1tbiex8DBmkS0FA33QAAsw
X-Headers-End: 1vIhWT-0007GS-Kf
Subject: [f2fs-dev] [PATCH v2] f2fs: fix has_curseg_enough_space to check
 all data segments for dentry blocks
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Yongpeng,

Thanks for your feedback! I've updated the patch per your suggestions:
- Merged the dentry block check into the main loop to avoid duplication
- Check data_blocks + dent_blocks for data segments since both can write to the same segment

Please see the v2 patch.

Best regards,
Xiaole



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
