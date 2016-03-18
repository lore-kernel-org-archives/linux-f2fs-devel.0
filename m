From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Thu, 17 Mar 2016 19:35:47 -0700
Message-ID: <CA+55aFxcwTtGCoWQSU6MXt_-0A5G5k=9EijSybEOSO38E_atZQ@mail.gmail.com>
References: <20160318005803.GA96629@jaegeuk.gateway>
	<CA+55aFxQnvWro5snYgRWu+A557+ZgY2Gxsj4MXmPYS-TOzKBLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxQnvWro5snYgRWu+A557+ZgY2Gxsj4MXmPYS-TOzKBLw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Mar 17, 2016 at 7:32 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
\>
> Then later, you add the Makefile and Kconfig rules to start building
> the files, but still nothing *uses* it.
>
> And then, after that, you have one commit that removes the old code,
> and switches over to the new code.

Oh, and after I actually finished the merge and did the test-compile,
I notice that much of this work has been rebased in the last hour or
two.

No. Just no.

I'm unpulling. None of this makes any sense. I can't take stuff like this.

              Linus
