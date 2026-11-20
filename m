Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7115606A6DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b1bnoYND;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZPb8o7q9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Xvb2FiR0;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=OhgHuGbI;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=K7JFmIP9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=HVB1VjCntl3jFBuc+Cc1KLSThg7nWR/JVTL9NMvZA+c=; b=b1bnoYND0b8XsvdEqpSrqpjA5F
	lfHMz4mZZAlfQk2ziDGSjx3KBIB0rKibY2IWk+6u6r64c2WI0DMkk3pyV1Xsi+b49XZxEcUSagkWZ
	LfDUasM7v6B0cnvMcoJ+VbyRITC8SNI5utDJlsFql6apO+x/L6NiQYzEht0nh4Da5Arw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCR-000000000fj-1rzn;
	Fri, 20 Nov 2026 19:23:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCN-000000000e4-37GI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P7MDqIWZojUEeeWbCXZTg55kM2pjBECbv1ObbA+Xh/8=; b=ZPb8o7q9lTgnLSZQZbqthFdpgz
 ElGy8XjYQRldDjR+cB2lkYuaLjAOAe3gJL2Q6grkLBE8VlwKPbW0PiY08sKIhW047zcwdOSfG0dtx
 etpuSVmQuRzOJWI4eGfEt3q1mUpGCHQ+dZO/TEXSoEcsyng7Ijbh33UCFC4QK7A0AV9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P7MDqIWZojUEeeWbCXZTg55kM2pjBECbv1ObbA+Xh/8=; b=Xvb2FiR0g0IW8tQEaPuCB6G3xl
 mcxo/hUgw0aafyxSKCHtQGE318gVJO9vjZop9oJz3RwyZClyOivB1WvqgGvAbT2tzrP08InipMTp4
 X0+i24kkkqIutJRwNuJqfsE7S069nerTueD0/WEYOvXdRsnwZKAgJi3iV0FHG7FQ7RI4=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCN-0000000017l-0amO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:03 +0000
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKJ1wRm3343271
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=P7MD
 qIWZojUEeeWbCXZTg55kM2pjBECbv1ObbA+Xh/8=; b=OhgHuGbIKcSl86goqvvX
 QmiWCutHw5qdMVv+p1Zl8sYep17HEbO/CGpyiVaPsq/1pKaOByLjf4j+RBdM5iYU
 5r8/xvFahvcaJLJlu4uxs0kQUzYH80eqEb7axjQ7oe0kZXKKpxsDhJNvhKmfezxE
 D7ysJLFUbTOGhdmmqO0LSkj9+6+MnOyjlza/q7EejZmtJV84tdKNlfgYfmZTx2sk
 1Chu7gOzDB4klXzehUAN+5j00avdEVomQYxkGOdJ5mVDaKBhTsou/vWoGiB177RB
 fGmx+HCqPR5u8Es/0hyOXOmPuOYNI9a0tfAVBhF1dPRhejYF5r8Y78QHoK5pXfnu
 3Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2kncm9w9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:57 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-92106c98714so26977886d6.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202576; x=1795807376;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P7MDqIWZojUEeeWbCXZTg55kM2pjBECbv1ObbA+Xh/8=;
 b=K7JFmIP9aEr74i18z6NnPN7nKdvA9VRadRMMX6au5EsxvwVxu8Rbo1ZTNpokudWV+i
 OGyQFIBRilEl57QgOelTmL/MOGLK7c+/sZxrOD07khQjcwEfEf2c1hEaHbjU6L2D1U0g
 CL6dwz/QpEfzwlPMWrMoyoiLI8BBoSbYVvYI4N7/+DYlpMJgRXuqFFzD+DE1DtTjgmZT
 qNTUpTRf2SRFM0VbYt11qn2fRt6CT7ExFuz+kcuUdBs/JWo8L+A+KJlgXq2lFJAGz+SH
 rkcW1EgEw7WnCHuirx3adG3mmKfRQ0YTeLk4aghxX0y/NA/WoVtJNNQwk5ZJGmPqDrdH
 8o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202576; x=1795807376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P7MDqIWZojUEeeWbCXZTg55kM2pjBECbv1ObbA+Xh/8=;
 b=SvMAsoCLNTvdOwUXoMcOcOrvIUz0+Ven9KYk4niVrE5eSRY+q665OPOfsei9GHiS1d
 Vld8MGkDHPHNP3NV536y+I6b6HyKkogmHHsmNghlKNn4nGbV/zqmA+yQjyUB+GG7hZ25
 jLrFa0CIzYt/a4PZkvNwC8P2lpLTxwJbHEUBkaFhmIDnD6+hjDafQMeveMtqA8qOQNGw
 7T3uYIyPCq9PyMpAqsh5+MdQj3BlS4ETY9QiMMgq5Z8/3UrM0SubqvXIVDivbICpOEYO
 tODGmO12PMwAcknuCptaXZtysPXjuR9QFHI2HYTIeO5phhX2xgg/FbM2rlAHxvlXQgoW
 SeAA==
X-Forwarded-Encrypted: i=1;
 AL+hErFf/uNhzST/bmxB1SdWUGSoIXo8sVf0X40KvL9P1bgfN296Y0NSrf8V6YKRnB33rvdzSz8JLDkhI5zzrQFYdRy8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z//WTmnda6RWVGQOAgSgPZlrKeqeKEdsxCQlnreR5CN3cihDyCy
 PYj/0Qfj0qsjIJ9ULxK3iF68GoB6niWrorbdPOO2QlLD/AdMpVkvXeYSNK45UI9SL9DYbx1xF/c
 jY4rKb7H3Bhw1wZDsZXCgMux/P0ssd1g1AykDUbwKH/y2+M7/MeCkzCQK/0fVKWeaYo7y02pzUx
 nqVTKkKb8=
X-Gm-Gg: AZFdTZdcQrUf4kDNGPx8Ms2KyJo2pI0pamkUUTCNE5RPtIvWXkyZ+inemMkQ5jkDz2C
 KKufc69tsNHrpurKzH3WVkz7yk7sWiIUdovYvIOrhQqwV9rT7qRAUqWXSQp/wHtOFk6cdhzY9QQ
 IWfYdYMo0ml6pcaYvzAnTHU/5rVC/vDAWiNCkcd0apz8hYPnSmQF56hzmSp6Txb7yZi0Vyy/6Eu
 9vMyQ3k0p2QS0YGlWYQVyQJ5uKylh7guT7VbRTQW4OD5XeYbOWUXhEjtBFb1kyOxjNmt8MJ1ZZb
 8MJ4PcZsD3UHSjjLju6vcP+yPohkX/0M/BCVc4GPNCO9NwB6/WO5zjRFrDpITFPnYeSZx6pcCU+
 lZy06DWRPEvNAK5AoUoVz9uZWmqc5JFH3cS0k4KOozsRInt3rg4Vr+1C0TPnLre91tAjBbVS/Mk
 80K4LrHaTW9i7OKfbYN+1y
X-Received: by 2002:a05:6214:5d01:b0:91e:f153:6a85 with SMTP id
 6a1803df08f44-92134b7fc22mr65998486d6.45.1795202576616; 
 Fri, 20 Nov 2026 11:22:56 -0800 (PST)
X-Received: by 2002:a05:6214:5d01:b0:91e:f153:6a85 with SMTP id
 6a1803df08f44-92134b7fc22mr65998286d6.45.1795202576230; 
 Fri, 20 Nov 2026 11:22:56 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:55 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:18 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-15-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=2261;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=BnnKomBYNrhKRGdVIa0oFiDxvfVE+S/oarpFk8m1jFA=;
 b=mCikb+bAMyjGzUUr4rtJL12xKk9k/Gj4hNI3masYCA7bvsGkhcXcUO9kw3Fy7C0m4i6Jy207K
 /A7bEBs+0oQBh2AykU3/iMYx0vwWoq2fi8qxeGIVpo5zTyOY/Y8ZoIK
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: UxqMkGTf-QE1iHtGtAQfr-W3J6-bcDkJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX5mskg8ODJpTL
 6U457C3SY8XpKiJbCJaDu3X+08xE1Ukj2Jf+ojwA0dQ1S2U3OIX8Vi3N/7dF5R5mvfeIEUwaWPb
 zJFRgdECs1LYNdTfiyv4k1F3ggXlxO5Fg6Wba3jAXX5gNmV4Ocwc
X-Proofpoint-ORIG-GUID: UxqMkGTf-QE1iHtGtAQfr-W3J6-bcDkJ
X-Authority-Analysis: v=2.4 cv=P9GvFSAu c=1 sm=1 tr=0 ts=6b009e11 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=AeLCns142kJ8KbD9VaQA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXxeN3JQTUE90G
 fy/s0jVye27olJ+6gvgA335cJM08aiGA+u9IhOJzRYHYBdFjsu03q14vuPs9Gg2egZk00SDRbIU
 YI1Sk20AaPkrtlmZfWWJCu2BKfN6/j1hT0V6zpFzCvE6pUNLLwRHKGTQJ3jbuIWoOrXcNcHV4kg
 SvoE0xCCdY/OQ5uTEK88fHNJDcCovH9mgGKyp/VpaaLBS5DDjT61k1+rDhY0hDJoQx2jAqFdzEW
 Z9yn5r9Yw1lu3uhcAGakWuj6/amDKkZuF25MURMEbrPoUwRPUTzcwFOHAaEhzKVle3GpTfJeGOf
 GOZN+tzBVHvor01ra6rJTsoGdKwtqcwUob56eRzh+/G9d467++etpklhdKI3BVxUPZh3xmcbA5V
 bdrXrQpuebUTLbAYfmzPGaI0VN4vAXsBxhHsKFmPfWKFv8EyX322quldaCyk5SdU48Wxuwwj8v4
 KBvKKKJXx2OztxP9YcA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=10 impostorscore=10
 adultscore=0 bulkscore=10 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCN-0000000017l-0amO
Subject: [f2fs-dev] [PATCH 15/28] f2fs: rename f2fs_write_multi_pages() to
 f2fs_write_multi_folios()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Tal Zussman <tz2294@columbia.edu>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Its compression context holds folios now. No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 2 +-
 fs/f2fs/data.c     | 4 ++--
 fs/f2fs/f2fs.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3484ffde8f88..5903fa034859 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1797,7 +1797,7 @@ static void dirty_partial_compressed_cluster(struct compress_ctx *cc)
 	}
 }
 
-int f2fs_write_multi_pages(struct compress_ctx *cc,
+int f2fs_write_multi_folios(struct compress_ctx *cc,
 					int *submitted,
 					struct writeback_control *wbc,
 					enum iostat_type io_type)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4489725efb57..8755323963b8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4574,7 +4574,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				}
 
 				if (!f2fs_cluster_can_merge_block(&cc, f_lblk)) {
-					ret = f2fs_write_multi_pages(&cc,
+					ret = f2fs_write_multi_folios(&cc,
 						&submitted, wbc, io_type);
 					if (!ret)
 						need_readd = true;
@@ -4696,7 +4696,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	/* flush remained pages in compress cluster */
 	if (f2fs_compressed_file(inode) && !f2fs_cluster_is_empty(&cc)) {
-		ret = f2fs_write_multi_pages(&cc, &submitted, wbc, io_type);
+		ret = f2fs_write_multi_folios(&cc, &submitted, wbc, io_type);
 		nwritten += submitted;
 		wbc->nr_to_write -= submitted;
 		if (ret) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fb827034a58b..5fd81b6cdef1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5028,7 +5028,7 @@ bool f2fs_all_cluster_folio_ready(struct compress_ctx *cc, struct folio **folios
 				int index, int nr_pages, bool uptodate);
 bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
 void f2fs_compress_ctx_add_folio(struct compress_ctx *cc, struct folio *folio);
-int f2fs_write_multi_pages(struct compress_ctx *cc,
+int f2fs_write_multi_folios(struct compress_ctx *cc,
 						int *submitted,
 						struct writeback_control *wbc,
 						enum iostat_type io_type);

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
