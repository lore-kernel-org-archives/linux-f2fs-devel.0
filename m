Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92843C88E75
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Mo57M+JrBvEt9/sBYJJqOpUXf2WBFza6flrfMm1Argo=; b=hBegb/ik9YRtJxd1zpBBOcU/s2
	AO5TrmhgDBd1jXHjbj6SbbdS59RdmcJAlPgE18ehVjrQ+WLXuJEvxrIQCKou9ah7dE+ErhAxXOFhy
	fMyqRcT/FxPvVAhJqp2Q3V6tj7m1UYPenV9ryM6uGX1PQaKpoiLfMazajHVoHMdWG+a0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6UjE-0007Kg-8S;
	Tue, 15 Sep 2026 15:05:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=17186df5e4=prabhakar.pujeri@dell.com>)
 id 1x6UjC-0007Ka-Sh for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:05:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=988TgQoS7paHUwcJekFHCNErcojXHWon2mhWc/T1nOs=; b=I5ULSSyllGVZAVYmHtn+/Rqg5c
 3Y7csb/Sx5kAZb3UBcGcd06j3IOtugTq8qAKiAYyee0OxikvuN1y2DfiPRSDbWaZDYkOvkvF1NaOJ
 z2g1tjo2vgzLpqVRtA0xliPsqRgbOUPTWb0IsGRdKL8ym0iQaZjGnHQY3CDlHR3tZ7Dw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=988TgQoS7paHUwcJekFHCNErcojXHWon2mhWc/T1nOs=; b=m
 oLiv+9+IqfiU9Au9tmHUWnGORBD6c9Ah+thabRucUQi+BJCT8zLrZFXaPRQxN4RkdvSzCQ+4rRuhE
 r3TnYc6lleHTjlOi4BLOn1EZBDm1eXYWtDdaonnE8TtXaVaiy8F/T5rfmPFTgM6B+Ax9boeTNlyzP
 4mKCV6ZAtsk8S7uI=;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6UjC-0006gW-Qt for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:05:47 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FD1k7T348406
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 15 Sep 2026 10:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=smtpout1; bh=988TgQoS7paHUwcJekFHCNErcojXHWon2mhW
 c/T1nOs=; b=HW66NxeMMOKLPd5KSj41xxqzT5JRlY/l3kvALTtJjZ1HciDCoJsO
 Nzx3dAuyeasH9HJMRVT3pd6OenIRfsOexZ9XdYUg/TyMjDjm7PVlEaClpBBlQJ8w
 nLOAEaya6QaiZwNDP98QNfRtjfo5QmwavGwQgU/JJ52Zu6+uzctRgAq7lQn0OTf1
 jHG0v4cQ0W3GvBtDjGPLL38QwP+Xz8pXgUZPM/mwK9h5/7jyszjECGQ6NsrVZn2h
 l8fP0z2JLJVoPFmTGmUnr+8mLhCiTD2162XGXSTietWhHop42Zg15+nDPkuWqlSq
 PgATC064aV1Cz0DZCmmmcqun2yxoaaAaqQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gn22gbq21-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 10:17:55 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FDxZmJ1640330
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 15 Sep 2026 10:17:54 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com
 [143.166.211.150])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gq688sm5t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 10:17:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1789481875; x=1821017875;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=988TgQoS7paHUwcJekFHCNErcojXHWon2mhWc/T1nOs=;
 b=D3ur2MqDGsI0w1IsCE59nEpxCPzueQdsEplfYheAB04IZRMGKrRyDOzq
 gZ4MC6Y2cRKcZvhVoP5WTLqbXM5YUNx2U2RB5inM4nMvFPaj+wJfslf72
 lA2wNZgyz4XCteHjrzGZ2ikfFgMpTiw6zA5EttZpbRPndC6qJ4Q3gL/+m
 /XhR+s9wUuhETyuEQWxXXrfDE4clRVTaQdwsc5qIW4j8D+zEwCEKiR1Mt
 7qADlNWUkvyPrpMyuJaYQvhYcIj0W1rz+7321ecqDvZJFsxzYq2fODeEG
 c0hmt5siUXDPigiYD6AbSQqOgdVXHzVHPLnyry2ah7AGeAk+Y4sf7S6V7 Q==;
X-CSE-ConnectionGUID: 7YLh5tLUSvWO+o0wcNw0JQ==
X-CSE-MsgGUID: xdf7yzi3SBi1NpfElWHKPQ==
X-LoopCount0: from 10.94.9.174
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com)
 ([10.94.9.174])
 by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Sep 2026 14:17:49 +0000
To: fstests@vger.kernel.org
Date: Tue, 15 Sep 2026 14:17:39 +0000
Message-ID: <20260915141745.4299-1-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfXzb2IeJOyDMci
 w55MNtjhmzvfr0PUeyouIXPFTykCMFobmfmFCZz5s37VOdqyMv0VqVskZVjeYiaKAs7mPYG3/kh
 c7w5i1Q75s2GM+PhCguzYX13tzyO5l6HpMhvApCuM8UaoCOfC2jIy294EuGm8bxj44OD5rIa806
 NIRpp5yKJ+trOEefJueIzBPRNPjftNKxBsT6J5jfiFRL2HCUlg8O9g93gfaQwHn90P9gqpUv8YP
 twcbQFeMuSMF8l3I5Xyt33XB1q85ShAa7JYGPN7FJSmUKHxzAU/dIGIOw0WxxLcnWYPsOVSvuwf
 8okmzljz3CczaDLg21bTCc3sznVnEug7yKngJF4pg5jCKBsQo8DSDA2PdLLioVq9HwwHc+tAjot
 8gXXFsFRUIY/nUNPFhll2Ap/sLa/YreZS89jay3ocUUobcDj3LzcVdRYfE6+diGIoPrjKXgdtCr
 530RnZYhgjmN+yrmNxQ==
X-Proofpoint-GUID: qxnlthTQx23amtkWg9Ff2pSB4s04ORXy
X-Proofpoint-ORIG-GUID: qxnlthTQx23amtkWg9Ff2pSB4s04ORXy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfX2foENMC2SmNr
 KBuU4q8hM97Ud1G3KxLFQRXvTJfrvcmw/hMSWsdY2CEoWn23J8XrZ7llf/XdZTG4Pgib7eeKwJM
 VJfmqbU45C66obapwVTLrySuJpbzTtA=
X-Authority-Analysis: v=2.4 cv=T+UZ3PKQ c=1 sm=1 tr=0 ts=6aa95393 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=2Lpba0WeoN7BYVdwMO11:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=EjSTBG_SgHjXaJ5rYncA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150208
X-Headers-End: 1x6UjC-0006gW-Qt
Subject: [f2fs-dev] [PATCH v3 0/6] xfstests: add missing _require_scratch
 checks
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
From: Prabhakar Pujeri via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Zorro Lang <zlang@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-unionfs@vger.kernel.org,
 quwenruo.btrfs@gmx.com, linux-f2fs-devel@lists.sourceforge.net,
 Anand Jain <asj@kernel.org>, Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
 linux-btrfs@vger.kernel.org, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Filipe Manana <fdmanana@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Fully consolidated resend of all remaining _require_scratch fixes, as
requested by Zorro on the v2 cover.

All of these patches add a single missing _require_scratch check; with
the exception of btrfs/333 (which places it at the top of
_require_btrfs_iouring_encoded_read(), per Qu Wenruo's earlier review)
they are plain one-line adds directly after the resource checks.  No
other changes.

v3:
- Merge ALL six single-line fixes into one series, per Zorro's request
  of 2026-09-03 on the v2 cover letter.
- Add Johannes Thumshirn's R-b for btrfs/273 and Chao Yu's R-b for
  f2fs/015,016 (both since v2).
- No code changes; patch contents are identical to the v2/v3 versions
  previously posted individually.

v2 pieces (this and the three it pulls forward) for reference:
- [PATCH v2 0/3] https://lore.kernel.org/fstests/20260903035344.752-1-prabhakar.pujeri@dell.com/
- btrfs/333 v3 https://lore.kernel.org/fstests/20260831104200.2269-1-prabhakar.pujeri@dell.com/ (v1; v3 was posted but is not archived)
- btrfs/273 v2 https://lore.kernel.org/fstests/20260902050145.2439-1-prabhakar.pujeri@dell.com/ (v1; v2 was posted but is not archived)
- overlay/081 v2 https://lore.kernel.org/fstests/20260901132438.759-1-prabhakar.pujeri@dell.com/

Reviewed-bys carried (per the individual threads):
- Darrick J. Wong: generic/590,735 and generic/795
- Zorro Lang + Chao Yu: f2fs/015,016
- Qu Wenruo: btrfs/333 (v3) and btrfs/273 (v2)
- Johannes Thumshirn: btrfs/273 (v2, second R-b)
- Amir Goldstein: overlay/081 (as Acked/Reviewed on v1; kept)

Prabhakar Pujeri (6):
  generic/590,735: add missing _require_scratch check
  generic/795: add missing _require_scratch check
  f2fs/015,016: add missing _require_scratch checks
  btrfs/333: require scratch before checking encoded reads
  btrfs/273: add missing _require_scratch check
  overlay/081: add missing _require_scratch check

 common/btrfs      | 1 +
 tests/btrfs/273   | 1 +
 tests/f2fs/015    | 1 +
 tests/f2fs/016    | 1 +
 tests/generic/590 | 1 +
 tests/generic/735 | 1 +
 tests/generic/795 | 2 ++
 tests/overlay/081 | 1 +
 8 files changed, 9 insertions(+)

Base: upstream master a370dcbed43563f0462801e889e0eceb93c7cfad
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
