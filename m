From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: [PATCH 1/2] f2fs: detect host-managed SMR by feature
 flag
Date: Thu, 25 Aug 2016 04:40:08 +0200
Message-ID: <20160825024008.GB8158@schmorp.de>
References: <20160614184322.88117-1-jaegeuk@kernel.org>
	<BY2PR04MB19767501012B2D01073F1AA09F550@BY2PR04MB1976.namprd04.prod.outlook.com>
	<20160615163246.GA93951@jaegeuk>
	<CAJVOszCrULuMVwhcoaSnP=noa4SajON2UDyz3pVdG=jSPn0P_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1bckpw-0003HT-QA
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 02:56:12 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bckpu-00072n-Rz
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Aug 2016 02:56:12 +0000
Content-Disposition: inline
In-Reply-To: <CAJVOszCrULuMVwhcoaSnP=noa4SajON2UDyz3pVdG=jSPn0P_A@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Shaun Tancheff <shaun@tancheff.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Wed, Aug 24, 2016 at 03:31:39PM -0500, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
> > IIRC, we discussed about HASMR with Marc Lehmann last year, and he gave the
> > below link which sums up.
> >
> > https://urldefense.proofpoint.com/v2/url?u=http-3A__comments.gmane.org_gmane.linux.file-2Dsystems.f2fs_2854&d=CwIBAg&c=IGDlg0lD0b-nebmJJ0Kp8A&r=Wg5NqlNlVTT7Ugl8V50qIHLe856QW0qfG3WVYGOrWzA&m=3Uw29rZTMJsKnUE9bBduFOdp3OiEwJhpgbJ9GmyO_SU&s=YNxrXKMJpd-BPHnYG8ctqg6ct58p2yqO3BRKlbjBO_s&e=
> > https://urldefense.proofpoint.com/v2/url?u=http-3A__blog.schmorp.de_2015-2D10-2D08-2Dsmr-2Darchive-2Ddrives-2Dfast-2Dnow.html&d=CwIBAg&c=IGDlg0lD0b-nebmJJ0Kp8A&r=Wg5NqlNlVTT7Ugl8V50qIHLe856QW0qfG3WVYGOrWzA&m=3Uw29rZTMJsKnUE9bBduFOdp3OiEwJhpgbJ9GmyO_SU&s=SC_RkdkfDQZTeIccq0o1zE4siI_RgDL4UhiVc1VzENY&e=
> 
> I think above applies to 'drive managed' SMR where the upper level
> has no insight into the underlying zone layout.

That's correct.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
