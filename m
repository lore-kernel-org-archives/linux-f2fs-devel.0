From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: f2fs: kernel BUG at fs/f2fs/segment.h:543
Date: Wed, 09 Apr 2014 11:57:36 -0400
Message-ID: <53456DF0.5060605@oracle.com>
References: <53401D4A.1020203@oracle.com>
	<COL402-EAS13359D6EB23C18DA0BBE9DAAB6A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sasha.levin@oracle.com>) id 1WXusm-0006CE-4M
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Apr 2014 15:57:48 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WXusl-0000zR-Bb
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Apr 2014 15:57:48 +0000
In-Reply-To: <COL402-EAS13359D6EB23C18DA0BBE9DAAB6A0@phx.gbl>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchaochina@hotmail.com>, jaegeuk.kim@samsung.com
Cc: 'Dave Jones' <davej@redhat.com>, 'LKML' <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 04/09/2014 11:51 AM, Chao Yu wrote:
> Hi Levin,
> 
> Could you share dump code info like following one which can be generated
> by 'objdump -Dl f2fs.ko > obj'.
> It may help us to get a clue for this problem.
> 
> verify_block_addr()
> segment.h:543 (discriminator 3)
>     2f35:       39 55 ec                cmp    %edx,-0x14(%ebp)
> segment.h:542 (discriminator 3)
>     2f38:       8d 44 02 ff             lea    -0x1(%edx,%eax,1),%eax
> segment.h:543 (discriminator 3)
>     2f3c:       0f 82 dc 01 00 00       jb     311e <f2fs_submit_page_mbio+0x22e>
> segment.h:544
>     2f42:       39 45 ec                cmp    %eax,-0x14(%ebp)
>     2f45:       0f 87 d1 01 00 00       ja     311c <f2fs_submit_page_mbio+0x22c>


verify_block_addr():
/home/sasha/linux-next/fs/f2fs/data.c:1079 (discriminator 3)
    f710:       49 8b 45 38             mov    0x38(%r13),%rax
/home/sasha/linux-next/fs/f2fs/segment.h:540 (discriminator 3)
    f714:       41 8b 8d d0 06 00 00    mov    0x6d0(%r13),%ecx
/home/sasha/linux-next/fs/f2fs/segment.h:541 (discriminator 3)
    f71b:       44 8b 40 78             mov    0x78(%rax),%r8d
/home/sasha/linux-next/fs/f2fs/segment.h:540 (discriminator 3)
    f71f:       8b 80 84 00 00 00       mov    0x84(%rax),%eax
    f725:       d3 e0                   shl    %cl,%eax
/home/sasha/linux-next/fs/f2fs/segment.h:543 (discriminator 3)
    f727:       45 39 c6                cmp    %r8d,%r14d
/home/sasha/linux-next/fs/f2fs/segment.h:542 (discriminator 3)
    f72a:       45 8d 4c 00 ff          lea    -0x1(%r8,%rax,1),%r9d
/home/sasha/linux-next/fs/f2fs/segment.h:543 (discriminator 3)
    f72f:       73 1f                   jae    f750 <f2fs_submit_page_mbio+0xa0>
/home/sasha/linux-next/fs/f2fs/segment.h:544
    f731:       49 8b 7d 00             mov    0x0(%r13),%rdi
    f735:       44 89 f1                mov    %r14d,%ecx
    f738:       48 c7 c2 00 00 00 00    mov    $0x0,%rdx
    f73f:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi
    f746:       31 c0                   xor    %eax,%eax
    f748:       e8 00 00 00 00          callq  f74d <f2fs_submit_page_mbio+0x9d>
/home/sasha/linux-next/fs/f2fs/segment.h:547
    f74d:       0f 0b                   ud2
    f74f:       90                      nop
/home/sasha/linux-next/fs/f2fs/segment.h:550
    f750:       45 39 ce                cmp    %r9d,%r14d
    f753:       76 0b                   jbe    f760 <f2fs_submit_page_mbio+0xb0>
    f755:       0f 0b                   ud2
    f757:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
    f75e:       00 00


Thanks,
Sasha

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
